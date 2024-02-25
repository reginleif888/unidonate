import RBTree "mo:base/RBTree";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import List "mo:base/List";
import Vector "mo:vector/Class";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat64 "mo:base/Nat64";
import Time "mo:base/Time";
import Int "mo:base/Int";
import UUID "mo:uuid/UUID";
import Source "mo:uuid/async/SourceV4";
import Uuid "mo:uuid/UUID";
import Nat32 "mo:base/Nat32";
import Option "mo:base/Option";
import Blob "mo:base/Blob";
import Error "mo:base/Error";
import Principal "mo:base/Principal";
import Timer "mo:base/Timer";
import Base58Check "mo:motoko-bitcoin/Base58Check";

import BitcoinIntegration "bitcoin-integration";
import BitcointIntegrationTypes "bitcoin-integration/types";
import Utils "utils";
import ImageStorage "image-storage";

import Types "./types";

actor class Main(initialOwner : ?Principal) {

  let g = Source.Source();

  // --------------------------------------

  private let ownersMap = RBTree.RBTree<Principal, ()>(Principal.compare);

  ignore do ? {
    ownersMap.put(initialOwner!, ());
  };

  stable var stableOwnersMap = ownersMap.share();

  private let usedTxMap = RBTree.RBTree<Text, ()>(Text.compare);
  stable var stableUsedTxMap = usedTxMap.share();

  let schools : Vector.Vector<Types.School> = Vector.Vector<Types.School>();
  stable var stableSchools = schools.share();

  let schoolsMap : RBTree.RBTree<Text, Nat> = RBTree.RBTree<Text, Nat>(Text.compare);
  stable var stableSchoolsMap = schoolsMap.share();

  let students : Vector.Vector<Types.Student> = Vector.Vector<Types.Student>();
  stable var stableStudents = students.share();

  let studentsMap : RBTree.RBTree<Text, Nat> = RBTree.RBTree<Text, Nat>(Text.compare);
  stable var stableStudentsMap = studentsMap.share();

  let donations : Vector.Vector<Types.Donation> = Vector.Vector<Types.Donation>();
  stable var stableDonations = donations.share();

  let donationsAmountMap : RBTree.RBTree<BitcointIntegrationTypes.Satoshi, List.List<Nat>> = RBTree.RBTree<BitcointIntegrationTypes.Satoshi, List.List<Nat>>(Nat64.compare);
  stable var stableDonationsAmountMap = donationsAmountMap.share();

  let donationsVerifiedMap : RBTree.RBTree<Int, List.List<Nat>> = RBTree.RBTree<Int, List.List<Nat>>(Int.compare);
  stable var stableDonationsVerifiedMap = donationsVerifiedMap.share();

  let donationsMap : RBTree.RBTree<Text, Nat> = RBTree.RBTree<Text, Nat>(Text.compare);
  stable var stableDonationsMap = donationsMap.share();

  // Fot testing
  private stable let ownerExtendedPublicKeyBase58Check : Text = "tprv8ZgxMBicQKsPdgnvFHcRWyp7VYvmPnhCpKjTCLDts5XDJYAApXiN7tCeEiprLPAFegEUr2cCoug4116oqYtPWHWTCQ9H1Qbkwu63csXJSvv";
  private stable var currentChildKeyIndex : Nat32 = 0;

  private stable var currentMemoryOffset : Nat64 = 2;
  private stable var currentTimer : Timer.TimerId = 0;

  var imgData : RBTree.RBTree<Text, Types.ImageObject> = RBTree.RBTree<Text, Types.ImageObject>(Text.compare);
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

  public shared ({ caller }) func getOwners() : async [Principal] {
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

  public query func getDonations({ sorting; page; perPage } : Types.GetDonationsPayload) : async Types.GetDonationsResponse {
    let { field; order } = Option.get(sorting, { field = #verifiedAt; order = #descending });

    let sortedDonations = switch (field) {
      case (#verifiedAt) {
        Utils.mapAndSortTreeToRecords(donationsVerifiedMap, donations, order);
      };
      case (#amount) {
        Utils.mapAndSortTreeToRecords(donationsAmountMap, donations, order);
      };
    };

    let size = sortedDonations.size();

    if (size == 0) {
      return {
        donations = [];
        total = size;
      };
    };

    let startIndex = Nat.min(size - 1, page * perPage);
    let endIndex = Nat.min(size, (page + 1) * perPage);

    let paginatedDonations = Vector.Vector<Types.Donation>();

    for (index in Iter.range(startIndex, endIndex - 1)) {
      paginatedDonations.add(sortedDonations.get(index));
    };

    let response : Types.GetDonationsResponse = {
      donations = Vector.toArray(paginatedDonations);
      total = size;
    };

    return response;
  };

  public query func getDonationById(donationId : Text) : async Types.Donation {
    let ?donationIndex = donationsMap.get(donationId) else throw Error.reject("Donation is not found by provided ID.");
    let donation = donations.get(donationIndex);

    return donation;
  };

  public query func getSchools({ filters; page; perPage } : Types.GetSchoolsPayload) : async Types.GetSchoolsResponse {
    let total = schools.size();

    var filteredSchoolsList = schools;

    if (Text.size(filters.schoolName) > 0 or filters.active) {
      filteredSchoolsList := Vector.Vector<Types.School>();

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

    let paginatedSchools = Vector.Vector<Types.School>();

    for (index in Iter.range(startIndex, endIndex - 1)) {
      paginatedSchools.add(filteredSchoolsList.get(index));
    };

    let response : Types.GetSchoolsResponse = {
      schools = Vector.toArray(paginatedSchools);
      total = filteredSize;
    };

    return response;
  };

  public query func getSchoolById(schoolId : Text) : async Types.School {
    let ?schoolIndex = schoolsMap.get(schoolId) else throw Error.reject("School is not found by provided ID.");
    let school = schools.get(schoolIndex);

    return school;
  };

  public query func getStudents(schoolId : Text, { filters; page; perPage } : Types.GetStudentsPayload) : async Types.GetStudentsResponse {
    let studentsBySchool = students
    |> Vector.toArray(_)
    |> Array.filter<Types.Student>(_, func(student) { student.schoolId == schoolId });

    let total = Array.size(studentsBySchool);

    var filteredStudentsList : Vector.Vector<Types.Student> = Vector.fromArray(studentsBySchool);

    if (Text.size(filters.studentName) > 0 or filters.active) {
      filteredStudentsList := Vector.Vector<Types.Student>();

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

    let paginatedStudents = Vector.Vector<Types.Student>();

    for (index in Iter.range(startIndex, endIndex - 1)) {
      paginatedStudents.add(filteredStudentsList.get(index));
    };

    let response : Types.GetStudentsResponse = {
      students = Vector.toArray(paginatedStudents);
      total = filteredSize;
    };

    return response;
  };

  public query func getStudentById(schoolId : Text) : async Types.Student {
    let ?studentIndex = studentsMap.get(schoolId) else throw Error.reject("Student is not found by provided ID.");
    let student = students.get(studentIndex);

    return student;
  };

  // --------------------------------------

  public shared ({ caller }) func addSchool(payload : Types.AddSchoolPayload) : async () {
    await* assertOwnerAccess(caller);

    let schoolId = UUID.toText(await g.new());

    let newSchool : Types.School = {
      id = schoolId;
      name = payload.name;
      location = payload.location;
      website = payload.website;
      students = [];
      images = await* generateImages(payload.images);
      active = true;
    };

    schoolsMap.put(newSchool.id, schools.size());
    schools.add(newSchool);
  };

  public shared ({ caller }) func updateSchool(schoolId : Text, payload : Types.UpdateSchoolPayload) : async () {
    await* assertOwnerAccess(caller);

    let ?schoolIndex = schoolsMap.get(schoolId) else throw Error.reject("School is not found by provided ID.");
    let school = schools.get(schoolIndex);

    let images : ?[Types.ClientImageObject] = await* generateImages(payload.images);
    var hasImagesToDelete = false;

    for (image in Iter.fromArray(Option.get(school.images, []))) {
      if (Array.find<Types.UploadImagePayload>(Option.get(payload.images, []), func(newImage) { newImage.id != null and newImage.id == ?image.id }) == null) {
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

    let updatedSchool : Types.School = {
      school with
      name = Option.get(payload.name, school.name);
      location = Option.get(payload.location, school.location);
      website = Option.get(payload.website, school.website);
      images = Option.get<?[Types.ClientImageObject]>(?images, school.images);
      active = Option.get(payload.active, school.active);
    };

    schools.put(schoolIndex, updatedSchool);
  };

  public shared ({ caller }) func addStudent(schoolId : Text, payload : Types.AddStudentPayload) : async () {
    await* assertOwnerAccess(caller);

    if (schoolsMap.get(schoolId) == null) {
      throw Error.reject("School is not found by provided ID.");
    };

    let studentId = UUID.toText(await g.new());

    let newStudent : Types.Student = {
      id = studentId;
      firstName = payload.firstName;
      lastName = payload.lastName;
      grade = payload.grade;
      dateOfBirth = payload.dateOfBirth;
      images = await* generateImages(payload.images);
      schoolId;
      active = true;
    };

    studentsMap.put(studentId, students.size());
    students.add(newStudent);

    let ?schoolIndex = schoolsMap.get(schoolId) else throw Error.reject("School is not found by provided ID.");
    let school = schools.get(schoolIndex);

    let newStudents : Buffer.Buffer<Text> = Buffer.fromArray(school.students);
    newStudents.add(studentId);

    schools.put(
      schoolIndex,
      {
        school with
        students = Buffer.toArray(newStudents)
      },
    );
  };

  public shared ({ caller }) func updateStudent(studentId : Text, payload : Types.UpdateStudentPayload) : async () {
    await* assertOwnerAccess(caller);

    let ?studentIndex = studentsMap.get(studentId) else throw Error.reject("Student is not found by provided ID.");
    let student = students.get(studentIndex);

    let images : ?[Types.ClientImageObject] = await* generateImages(payload.images);
    var hasImagesToDelete = false;

    for (image in Iter.fromArray(Option.get(student.images, []))) {
      if (Array.find<Types.UploadImagePayload>(Option.get(payload.images, []), func(newImage) { newImage.id != null and newImage.id == ?image.id }) == null) {
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

    let active = Option.get(payload.active, student.active);

    let updatedStudent : Types.Student = {
      student with
      firstName = Option.get(payload.firstName, student.firstName);
      lastName = Option.get(payload.lastName, student.lastName);
      grade = Option.get(payload.grade, student.grade);
      dateOfBirth = Option.get(payload.dateOfBirth, student.dateOfBirth);
      images = Option.get<?[Types.ClientImageObject]>(?images, student.images);
      active;
    };

    students.put(studentIndex, updatedStudent);

    let ?schoolIndex = schoolsMap.get(student.schoolId) else throw Error.reject("School is not found by provided ID.");
    let school = schools.get(schoolIndex);

    let newStudents : Buffer.Buffer<Text> = Buffer.fromArray(Array.filter<Text>(school.students, func(studentId) { studentId != student.id }));

    if (active) {
      newStudents.add(studentId);
    };

    schools.put(
      schoolIndex,
      {
        school with
        students = Buffer.toArray(newStudents)
      },
    );
  };

  public func createDonation(payload : Types.CreateDonationPayload) : async Types.CreateDonationResponse {
    if (Nat64.less(payload.amount, 1) == true) throw Error.reject("Amount must be more than 0 satoshi.");

    let paymentAddress = BitcoinIntegration.generateNextPaymentAddress(ownerExtendedPublicKeyBase58Check, currentChildKeyIndex);

    switch (paymentAddress) {
      case (null) {
        return throw Error.reject("Error occured when generating payment address.");
      };
      case (?address) {
        currentChildKeyIndex := currentChildKeyIndex + 1;
        let donationId = UUID.toText(await g.new());

        let newDonation : Types.Donation = {
          donationId;
          paymentAddress = address;
          schoolId = payload.schoolId;
          studentId = payload.studentId;
          amount = payload.amount;
          status = #Pending;
          allocations = payload.allocations;
          transactionId = null;
          verifiedAt = null;
        };

        donationsMap.put(donationId, donations.size());
        donations.add(newDonation);

        return { donationId; paymentAddress = address };
      };
    };
  };

  public func verifyDonation(payload : Types.VerifyDonationPayload) : async () {
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

    let verifiedAt = Time.now();

    let donationVerifiedList = Option.get<List.List<Nat>>(donationsVerifiedMap.get(verifiedAt), null);
    donationsVerifiedMap.put(verifiedAt, List.push(donationIndex, donationVerifiedList));

    let donationAmountList = Option.get<List.List<Nat>>(donationsAmountMap.get(currentDonation.amount), null);
    donationsAmountMap.put(currentDonation.amount, List.push(donations.size(), donationAmountList));

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
        verifiedAt = ?verifiedAt;
      },
    );
  };

  private func assertOwnerAccess(principal : Principal) : async* () {
    if (ownersMap.get(principal) == null) {
      throw Error.reject("No Access for this principal " # Principal.toText(principal));
    };
  };

  public query func http_request(request : Types.HttpRequest) : async Types.HttpResponse {
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

  private func generateImages(imageObjects : ?[Types.UploadImagePayload]) : async* ?[Types.ClientImageObject] {
    switch (imageObjects) {
      case (null) { null };
      case (?images) {
        let ids : Vector.Vector<Types.ClientImageObject> = Vector.Vector<Types.ClientImageObject>();

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
    let imageDataToProcess = imgData.entries()
    |> Iter.map<(Text, Types.ImageObject), Types.ImageObject>(_, func(entry) { entry.1 })
    |> Iter.toArray(_);

    let newCurrentMemoryOffset = ImageStorage.processImageDeletion(
      imageDataToProcess,
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

    let imageIdsToDelete = imageDataToProcess
    |> Array.mapFilter<Types.ImageObject, Text>(_, func(imageData) { if (imageData.isDeleted != true) { null } else { ?imageData.id } });

    for (imageId in Iter.fromArray(imageIdsToDelete)) {
      imgData.delete(imageId);
    };

    currentMemoryOffset := newCurrentMemoryOffset;
  };

  private func storeBlobImg(imgId : Text, imageBlob : Blob, name : Text, mimeType : Text) {
    let { imageSize; shift } = ImageStorage.storeBlobImageInMemory(imageBlob, currentMemoryOffset);

    imgData.put(imgId, { id = imgId; offset = currentMemoryOffset; size = imageSize; name; mimeType; isDeleted = false });
    currentMemoryOffset += Nat64.fromNat(imageSize) + shift;
  };

  private func loadBlobImg(imgId : Text) : ?Blob {
    let (imageOffset, imageSize) = Option.getMapped<Types.ImageObject, (Nat64, Nat)>(imgData.get(imgId), func(data) { (data.offset, data.size) }, (0, 0));
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
    stableDonationsAmountMap := donationsAmountMap.share();
    stableDonationsVerifiedMap := donationsVerifiedMap.share();
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
    donationsAmountMap.unshare(stableDonationsAmountMap);
    donationsVerifiedMap.unshare(stableDonationsVerifiedMap);
    imgData.unshare(stableImgData);
    ownersMap.unshare(stableOwnersMap);
    usedTxMap.unshare(stableUsedTxMap);
  };
};
