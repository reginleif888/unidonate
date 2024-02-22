import RBTree "mo:base/RBTree";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import List "mo:base/List";
import Vector "mo:vector/Class";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat64 "mo:base/Nat64";
import Time "mo:base/Time";
import Int "mo:base/Int";
import UUID "mo:uuid/UUID";
import Source "mo:uuid/async/SourceV4";
import Uuid "mo:uuid/UUID";
import HashMap "mo:base/HashMap";
import StableMemory "mo:base/ExperimentalStableMemory";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Int64 "mo:base/Int64";
import Blob "mo:base/Blob";
import Random "mo:base/Random";
import Nat8 "mo:base/Nat8";
import Error "mo:base/Error";
import Principal "mo:base/Principal";
import ExperimentalStableMemory "mo:base/ExperimentalStableMemory";
import Timer "mo:base/Timer";
import Base58Check "mo:motoko-bitcoin/Base58Check";
import Bip32 "mo:motoko-bitcoin/Bip32";
import Jacobi "mo:motoko-bitcoin/ec/Jacobi";
import Curves "mo:motoko-bitcoin/ec/Curves";
import Hmac "mo:motoko-bitcoin/Hmac";
import Hash "mo:motoko-bitcoin/Hash";
import Bech32 "mo:motoko-bitcoin/Bech32";
import Common "mo:motoko-bitcoin/Common";

import BitcoinIntegration "bitcoin-integration";
import BitcointIntegrationTypes "bitcoin-integration/types";
import BitcoinIntegrationUtils "bitcoin-integration/utils";

import ImageStorage "image-storage";

import Types "./types";
import Utils "utils";
import Payments "bitcoin-integration/payments";
import Network "bitcoin-integration/network";
import BIP32 "bitcoin-integration/bip32";
import BitcoinApi "bitcoin-integration/bitcoin-api";

actor class Main(initialOwner : ?Principal) {
  type Student = Types.Student;
  type School = Types.School;
  type Donation = Types.Donation;

  type ImageObject = Types.ImageObject;
  type EntityImage = Types.EntityImage;
  type DonationStatus = Types.DonationStatus;

  type GetSchoolsPayload = Types.GetSchoolsPayload;
  type GetSchoolsResponse = Types.GetSchoolsResponse;
  type AddSchoolPayload = Types.AddSchoolPayload;
  type UpdateSchoolPayload = Types.UpdateSchoolPayload;

  type GetStudentsPayload = Types.GetStudentsPayload;
  type GetStudentsResponse = Types.GetStudentsResponse;
  type AddStudentPayload = Types.AddStudentPayload;
  type UpdateStudentPayload = Types.UpdateStudentPayload;

  type CreateDonationPayload = Types.CreateDonationPayload;
  type CreateDonationResponse = Types.CreateDonationResponse;
  type VerifyDonationPayload = Types.VerifyDonationPayload;
  type GetDonationsPayload = Types.GetDonationsPayload;
  type GetDonationsResponse = Types.GetDonationsResponse;

  type HttpRequest = Types.HttpRequest;
  type HttpResponse = Types.HttpResponse;

  type ImageData = {
    offset : Nat64;
    size : Nat;
    name : Text;
    mimeType : Text;
    isDeleted : Bool;
  };

  let g = Source.Source();

  // --------------------------------------

  private let ownersMap = RBTree.RBTree<Principal, ()>(Principal.compare);
  stable var stableOwnersMap = ownersMap.share();

  private let usedTxMap = RBTree.RBTree<Text, ()>(Text.compare);
  stable var stableUsedTxMap = usedTxMap.share();

  ignore do ? {
    ownersMap.put(initialOwner!, ());
  };

  let schools : Vector.Vector<School> = Vector.Vector<School>();
  stable var stableSchools = schools.share();

  let schoolsMap : RBTree.RBTree<Text, Nat> = RBTree.RBTree<Text, Nat>(Text.compare);
  stable var stableSchoolsMap = schoolsMap.share();

  let students : Vector.Vector<Student> = Vector.Vector<Student>();
  stable var stableStudents = students.share();

  let studentsMap : RBTree.RBTree<Text, Nat> = RBTree.RBTree<Text, Nat>(Text.compare);
  stable var stableStudentsMap = studentsMap.share();

  let donations : Vector.Vector<Donation> = Vector.Vector<Donation>();
  stable var stableDonations = donations.share();

  let donationsMap : RBTree.RBTree<Text, Nat> = RBTree.RBTree<Text, Nat>(Text.compare);
  stable var stableDonationsMap = donationsMap.share();

  // Fot testing
  private stable let ownerExtendedPublicKeyBase58Check : Text = "tprv8ZgxMBicQKsPdgnvFHcRWyp7VYvmPnhCpKjTCLDts5XDJYAApXiN7tCeEiprLPAFegEUr2cCoug4116oqYtPWHWTCQ9H1Qbkwu63csXJSvv";
  private stable var currentChildKeyIndex : Nat32 = 0;

  private stable var currentMemoryOffset : Nat64 = 2;
  private stable var currentTimer : Timer.TimerId = 0;

  var imgData : RBTree.RBTree<Text, ImageData> = RBTree.RBTree<Text, ImageData>(Text.compare);
  stable var stableImgData = imgData.share();

  // --------------------------------------

  public shared ({ caller }) func isAdmin(principal : Principal) : async Bool {
    try {
      await* assertOwnerAccess(caller);
      return true;
    } catch (e) {
      return false;
    };
  };

  public shared ({ caller }) func getOwners(principal : Principal) : async [Principal] {
    await* assertOwnerAccess(caller);

    let ownerPrincipals = ownersMap.entries()
    |> Iter.map<(Principal, ()), Principal>(_, func((principal, _)) { principal })
    |> Iter.toArray(_);

    return ownerPrincipals;
  };

  public shared ({ caller }) func addOwner(principal : Principal) : async () {
    await* assertOwnerAccess(caller);
    ownersMap.put(principal, ());
  };

  public shared ({ caller }) func removeOwner(principal : Principal) : async () {
    await* assertOwnerAccess(caller);
    ownersMap.delete(principal);
  };

  // --------------------------------------

  public query func getDonations({ filters; page; perPage } : GetDonationsPayload) : async GetDonationsResponse {
    let total = donations.size();

    var filteredDonationsList = donations;

    if (Text.size(filters.donationId) > 0) {
      filteredDonationsList := Vector.Vector<Donation>();

      for (index in Iter.range(0, total - 1)) {
        let donation = donations.get(index);

        if (donation.donationId == filters.donationId) {
          filteredDonationsList.add(donation);
        };
      };
    };

    let filteredSize = filteredDonationsList.size();

    if (filteredSize == 0) {
      return {
        donations = [];
        total = filteredSize;
      };
    };

    let startIndex = Nat.min(filteredSize - 1, page * perPage);
    let endIndex = Nat.min(filteredSize, (page + 1) * perPage);

    let paginatedDonations = Vector.Vector<Donation>();

    for (index in Iter.range(startIndex, endIndex - 1)) {
      paginatedDonations.add(filteredDonationsList.get(index));
    };

    let response : GetDonationsResponse = {
      donations = Vector.toArray(paginatedDonations);
      total = filteredSize;
    };

    return response;
  };

  public query func getSchools({ filters; page; perPage } : GetSchoolsPayload) : async GetSchoolsResponse {
    let total = schools.size();

    var filteredSchoolsList = schools;

    if (Text.size(filters.schoolName) > 0 or filters.active) {
      filteredSchoolsList := Vector.Vector<School>();

      for (index in Iter.range(0, total - 1)) {
        let school = schools.get(index);

        if (Text.contains(school.name, #text(filters.schoolName)) and (filters.active == false or (filters.active and school.active))) {
          filteredSchoolsList.add(school);
        };
      };
    };

    let filteredSize = filteredSchoolsList.size();

    if (filteredSize == 0) {
      return {
        schools = [];
        total = filteredSize;
      };
    };

    let startIndex = Nat.min(filteredSize - 1, page * perPage);
    let endIndex = Nat.min(filteredSize, (page + 1) * perPage);

    let paginatedSchools = Vector.Vector<School>();

    for (index in Iter.range(startIndex, endIndex - 1)) {
      paginatedSchools.add(filteredSchoolsList.get(index));
    };

    let response : GetSchoolsResponse = {
      schools = Vector.toArray(paginatedSchools);
      total = filteredSize;
    };

    return response;
  };

  public query func getStudents(schoolId : Text, { filters; page; perPage } : GetStudentsPayload) : async GetStudentsResponse {
    let studentsBySchool : Buffer.Buffer<Student> = Buffer.Buffer<Student>(0);
    let studentsSize = students.size();

    for (index in Iter.range(0, students.size())) {
      if (students.get(index).schoolId == schoolId) {
        studentsBySchool.put(studentsBySchool.size(), students.get(index));
      };
    };

    let total = studentsBySchool.size();

    var filteredStudentsList : Vector.Vector<Student> = Vector.fromArray(Buffer.toArray(studentsBySchool));

    if (Text.size(filters.studentName) > 0 or filters.active) {
      filteredStudentsList := Vector.Vector<Student>();

      for (index in Iter.range(0, total - 1)) {
        let student = studentsBySchool.get(index);

        if (Text.contains(student.firstName # student.lastName, #text(filters.studentName)) and (filters.active == false or (filters.active and student.active))) {
          filteredStudentsList.add(student);
        };
      };
    };

    let filteredSize = filteredStudentsList.size();

    if (filteredSize == 0) {
      return {
        students = [];
        total = filteredSize;
      };
    };

    let startIndex = Nat.min(filteredSize - 1, page * perPage);
    let endIndex = Nat.min(filteredSize, (page + 1) * perPage);

    let paginatedStudents = Vector.Vector<Student>();

    for (index in Iter.range(startIndex, endIndex - 1)) {
      paginatedStudents.add(filteredStudentsList.get(index));
    };

    let response : GetStudentsResponse = {
      students = Vector.toArray(paginatedStudents);
      total = filteredSize;
    };

    return response;
  };

  // --------------------------------------

  public shared ({ caller }) func addSchool(payload : AddSchoolPayload) : async () {
    await* assertOwnerAccess(caller);

    let schoolId = UUID.toText(await g.new());

    let newSchool : School = {
      id = schoolId;
      name = payload.name;
      location = payload.location;
      website = payload.website;
      numberOfStudents = 0;
      images = await* generateImages(payload.images);
      active = true;
    };

    schoolsMap.put(newSchool.id, schools.size());
    schools.add(newSchool);
  };

  public shared ({ caller }) func updateSchool(schoolId : Text, payload : UpdateSchoolPayload) : async () {
    await* assertOwnerAccess(caller);

    let ?schoolIndex = schoolsMap.get(schoolId) else throw Error.reject("School is not found by provided ID.");
    let school = schools.get(schoolIndex);

    let images : ?[EntityImage] = await* generateImages(payload.images);
    var hasImagesToDelete = false;

    for (image in Iter.fromArray(Option.get(school.images, []))) {
      if (Array.find<ImageObject>(Option.get(payload.images, []), func(newImage) { newImage.id != null and newImage.id == ?image.id }) == null) {
        ignore do ? {
          imgData.put(
            image.id,
            {
              imgData.get(image.id)! with
              isDeleted = true
            },
          );
        };

        hasImagesToDelete := true;
      };
    };

    if (hasImagesToDelete) {
      ignore scheduleImageDeletion();
    };

    let updatedSchool : School = {
      school with
      name = Option.get(payload.name, school.name);
      location = Option.get(payload.location, school.location);
      website = Option.get(payload.website, school.website);
      images = Option.get<?[EntityImage]>(?images, school.images);
      active = Option.get(payload.active, school.active);
    };

    schools.put(schoolIndex, updatedSchool);
  };

  public shared ({ caller }) func addStudent(schoolId : Text, payload : AddStudentPayload) : async () {
    await* assertOwnerAccess(caller);

    if (schoolsMap.get(schoolId) == null) {
      throw Error.reject("School is not found by provided ID.");
    };

    let newStudent : Student = {
      id = UUID.toText(await g.new());
      firstName = payload.firstName;
      lastName = payload.lastName;
      grade = payload.grade;
      dateOfBirth = payload.dateOfBirth;
      images = await* generateImages(payload.images);
      schoolId;
      active = true;
    };

    studentsMap.put(schoolId, students.size());
    students.add(newStudent);
  };

  public shared ({ caller }) func updateStudent(studentId : Text, payload : UpdateStudentPayload) : async () {
    await* assertOwnerAccess(caller);

    let ?studentIndex = studentsMap.get(studentId) else throw Error.reject("Student is not found by provided ID.");
    let student = students.get(studentIndex);

    let images : ?[EntityImage] = await* generateImages(payload.images);

    let updatedStudent : Student = {
      student with
      firstName = Option.get(payload.firstName, student.firstName);
      lastName = Option.get(payload.lastName, student.lastName);
      grade = Option.get(payload.grade, student.grade);
      dateOfBirth = Option.get(payload.dateOfBirth, student.dateOfBirth);
      images = Option.get<?[EntityImage]>(?images, student.images);
      active = Option.get(payload.active, student.active);
    };

    students.put(studentIndex, updatedStudent);
  };

  public func createDonation(payload : CreateDonationPayload) : async CreateDonationResponse {
    if (Nat64.less(payload.amount, 1) == true) throw Error.reject("Amount must be more than 0 satoshi.");

    let paymentAddress = BitcoinIntegration.generateNextPaymentAddress(ownerExtendedPublicKeyBase58Check, currentChildKeyIndex);

    switch (paymentAddress) {
      case (null) {
        return throw Error.reject("Error occured when generating payment address.");
      };
      case (?address) {
        currentChildKeyIndex := currentChildKeyIndex + 1;
        let donationId = UUID.toText(await g.new());

        let newDonation : Donation = {
          donationId;
          paymentAddress = address;
          schoolId = payload.schoolId;
          studentId = payload.studentId;
          amount = payload.amount;
          status = #Pending;
          allocations = payload.allocations;
          transactionId = null;
        };

        donationsMap.put(donationId, donations.size());
        donations.add(newDonation);

        return { donationId; paymentAddress = address };
      };
    };
  };

  public func verifyDonation(payload : VerifyDonationPayload) : async () {
    let ?donationIndex = donationsMap.get(payload.donationId) else throw Error.reject("Donation is not found by provided ID.");

    let currentDonation = donations.get(donationIndex);

    if (currentDonation.status == #Verified) {
      throw Error.reject("Transaction is already verified.");
    };

    if (usedTxMap.get(payload.transactionId) != null) {
      throw Error.reject("Transaction id is already used.");
    };

    let isTransactionConfirmed = await BitcoinIntegration.checkIfTransactionIsConfirmed(currentDonation.paymentAddress, payload.transactionId, currentDonation.amount);

    if (isTransactionConfirmed == false) throw Error.reject("Transaction is not verified.");

    usedTxMap.put(payload.transactionId, ());
    donations.put(
      donationIndex,
      {
        donationId = currentDonation.donationId;
        transactionId = ?payload.transactionId;
        paymentAddress = currentDonation.paymentAddress;
        schoolId = currentDonation.schoolId;
        studentId = currentDonation.studentId;
        amount = currentDonation.amount;
        status = #Verified;
        allocations = currentDonation.allocations;
      },
    );
  };

  // --------------------------------------

  public query func http_request(request : HttpRequest) : async HttpResponse {
    if (request.method != "GET") {
      return Utils.http404(?"Path not found");
    };

    if (Text.contains(request.url, #text("imgId"))) {
      let imageId = Iter.toArray(Text.tokens(request.url, #text("imgId=")))[1];
      var picture = loadBlobImg(imageId);

      switch (picture) {
        case (null) {
          return Utils.http404(?"No picture available");
        };
        case (?pic) {
          return Utils.picture(pic);
        };
      };
    };

    return Utils.http404(?"Path not found");
  };

  // --------------------------------------

  private func assertOwnerAccess(principal : Principal) : async* () {
    if (ownersMap.get(principal) == null) {
      // throw Error.reject("No Access for this principal " # Principal.toText(principal));
    };
  };

  private func generateImages(imageObjects : ?[ImageObject]) : async* ?[EntityImage] {
    switch (imageObjects) {
      case (null) { null };
      case (?images) {
        let ids : Vector.Vector<EntityImage> = Vector.Vector<EntityImage>();

        for (image in Iter.fromArray(images)) {
          if (image.id != null) {
            ignore do ? {
              let imageData = imgData.get(image.id!)!;
              ids.add({
                id = image.id!;
                name = imageData.name;
                mimeType = imageData.mimeType;
              });
            };
          } else {
            let uniqueId = UUID.toText(await g.new());
            storeBlobImg(uniqueId, image.data, image.name, image.mimeType);
            ids.add({
              id = uniqueId;
              name = image.name;
              mimeType = image.mimeType;
            });
          };
        };

        ?Vector.toArray(ids);
      };
    };
  };

  private func scheduleImageDeletion() : async () {
    if (currentTimer != 0) {
      Timer.cancelTimer(currentTimer);
    };

    currentTimer := Timer.setTimer(#seconds(30), deleteBlobImgs);
  };

  private func deleteBlobImgs() : async () {
    let (imageIdsToDelete, imagesDataToProcess) = imgData.entries()
    |> Iter.map<(Text, ImageData), (Text, ImageStorage.ImageData)>(_, func((imageId, imageData)) { (imageId, { id = imageId; offset = imageData.offset; size = imageData.size; isDeleted = imageData.isDeleted }) })
    |> Iter.toArray(_)
    |> Array.foldLeft<(Text, ImageStorage.ImageData), (List.List<Text>, List.List<ImageStorage.ImageData>)>(_, (null, null), func((imageIdsToDelete, imagesDataToProcess), (imageId, imageData)) { (if (imageData.isDeleted) List.push(imageId, imageIdsToDelete) else imageIdsToDelete, List.push(imageData, imagesDataToProcess)) });

    let newCurrentMemoryOffset = ImageStorage.processAndShiftForDeletedImagesInMemory(
      List.toArray(imagesDataToProcess),
      func({ id; newOffset }) {
        ignore do ? {
          imgData.put(
            id,
            {
              imgData.get(id)! with
              offset = newOffset
            },
          );
        };
      },
    );

    for (imageId in Iter.fromList(imageIdsToDelete)) {
      imgData.delete(imageId);
    };

    currentMemoryOffset := newCurrentMemoryOffset;
  };

  private func storeBlobImg(imgId : Text, imageBlob : Blob, name : Text, mimeType : Text) {
    let { imageSize; shift } = ImageStorage.storeBlobImageInMemory(imageBlob, currentMemoryOffset);

    imgData.put(imgId, { offset = currentMemoryOffset; size = imageSize; name; mimeType; isDeleted = false });
    currentMemoryOffset += Nat64.fromNat(imageSize) + shift;
  };

  private func loadBlobImg(imgId : Text) : ?Blob {
    let (imageOffset, imageSize) = Option.getMapped<ImageData, (Nat64, Nat)>(imgData.get(imgId), func(data) { (data.offset, data.size) }, (0, 0));
    return ImageStorage.getBlobImageFromMemory(imageOffset, imageSize);
  };

  // --------------------------------------
  // --------------------------------------
  // --------------------------------------

  system func preupgrade() {
    stableSchools := schools.share();
    stableSchoolsMap := schoolsMap.share();
    stableStudents := students.share();
    stableStudentsMap := studentsMap.share();
    stableDonations := donations.share();
    stableDonationsMap := donationsMap.share();
    stableImgData := imgData.share();
    stableOwnersMap := ownersMap.share();
    stableUsedTxMap := usedTxMap.share();
  };

  system func postupgrade() {
    schools.unshare(stableSchools);
    schoolsMap.unshare(stableSchoolsMap);
    students.unshare(stableStudents);
    studentsMap.unshare(stableStudentsMap);
    donations.unshare(stableDonations);
    donationsMap.unshare(stableDonationsMap);
    imgData.unshare(stableImgData);
    ownersMap.unshare(stableOwnersMap);
    usedTxMap.unshare(stableUsedTxMap);
  };
};
