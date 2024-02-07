import RBTree "mo:base/RBTree";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import List "mo:base/List";
import Vector "mo:vector/Class";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import Array "mo:base/Array";
import Result "mo:base/Result";
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

import BitcoinIntegration "bitcoin-integration";
import BitcoinIntegrationUtils "bitcoin-integration/utils";

import Types "./types";
import Utils "utils";

actor class Main() {
  type Student = Types.Student;
  type School = Types.School;
  type SchoolsList = Types.SchoolsList;
  type StudentsList = Types.StudentsList;
  type StudentsListsMap = Types.StudentsListsMap;
  type AddSchoolPayload = Types.AddSchoolPayload;
  type AddStudentPayload = Types.AddStudentPayload;
  type GetSchoolsPayload = Types.GetSchoolsPayload;
  type GetSchoolsResponse = Types.GetSchoolsResponse;
  type GetDonationsPayload = Types.GetDonationsPayload;
  type GetDonationsResponse = Types.GetDonationsResponse;
  type HttpRequest = Types.HttpRequest;
  type HttpResponse = Types.HttpResponse;
  type Donation = Types.Donation;
  type DonationsList = Types.DonationsList;
  type DonationsMap = Types.DonationsMap;
  type CreateDonationPayload = Types.CreateDonationPayload;
  type CreateDonationResponse = Types.CreateDonationResponse;
  type VerifyDonationPayload = Types.VerifyDonationPayload;
  type DonationStatus = Types.DonationStatus;

  let g = Source.Source();

  // --------------------------------------

  let schools : SchoolsList = Vector.Vector<Types.School>();
  stable var stableSchools = schools.share();

  let studentsMap : StudentsListsMap = RBTree.RBTree<Text, List.List<Student>>(Text.compare);
  stable var stableStudentsMap = studentsMap.share();

  let donations : DonationsList = Vector.Vector<Donation>();
  stable var stableDonations = donations.share();

  let donationsMap : DonationsMap = RBTree.RBTree<Text, Nat>(Text.compare);
  stable var stableDonationsMap = donationsMap.share();

  // Fot testing
  private stable let ownerExtendedPublicKeyBase58Check : Text = "tpubDD9S94RYo2MraS7QbRhA64Nr56BzCYN2orJUkk2LE4RkB2npb9SFyiCuofbapC9wNW2hLJqkWwSpGoaE9pZC6fLBQdms5HYS9dsvw79nSWy";
  private stable var currentChildKeyIndex : Nat = 0;

  private stable var currentMemoryOffset : Nat64 = 2;
  var imgOffset : RBTree.RBTree<Text, Nat64> = RBTree.RBTree<Text, Nat64>(Text.compare);
  stable var stableImgOffset = imgOffset.share();
  var imgSize : RBTree.RBTree<Text, Nat> = RBTree.RBTree<Text, Nat>(Text.compare);
  stable var stableImgSize = imgSize.share();

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
      total = paginatedDonations.size();
    };

    return response;
  };

  public query func getSchools({ filters; page; perPage } : GetSchoolsPayload) : async GetSchoolsResponse {
    let total = schools.size();

    var filteredSchoolsList = schools;

    if (Text.size(filters.schoolName) > 0) {
      filteredSchoolsList := Vector.Vector<School>();

      for (index in Iter.range(0, total - 1)) {
        let school = schools.get(index);

        if (Text.contains(school.name, #text(filters.schoolName))) {
          filteredSchoolsList.add(schools.get(index));
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
      total = paginatedSchools.size();
    };

    return response;
  };

  private func _addSchool(payload : AddSchoolPayload) : async* () {
    let schoolId = UUID.toText(await g.new());

    let imageId : ?Text = switch (payload.imageBlob) {
      case null { null };
      case (?blob) {
        let uniqueId = UUID.toText(await g.new());
        storeBlobImg(uniqueId, blob);
        ?uniqueId;
      };
    };

    let newSchool : School = {
      id = schoolId;
      name = payload.name;
      location = payload.location;
      website = payload.website;
      numberOfStudents = 0;
      imageId;
    };

    schools.add(newSchool);
    studentsMap.put(newSchool.id, null);
  };

  public func addSchool(payload : AddSchoolPayload) : async () {
    ignore _addSchool(payload);
  };

  public query func getStudents(schoolId : Text) : async Result.Result<[Student], Text> {
    let ?studentsList = studentsMap.get(schoolId) else return #err("School is not found by provided ID.");
    return #ok(List.toArray<Student>(studentsList));
  };

  private func _addStudent(schoolId : Text, payload : AddStudentPayload) : async* Result.Result<(), Text> {
    let ?studentsList = studentsMap.get(schoolId) else return #err("School is not found by provided ID.");

    let imageId : ?Text = switch (payload.imageBlob) {
      case null { null };
      case (?blob) {
        let uniqueId = UUID.toText(await g.new());
        storeBlobImg(uniqueId, blob);
        ?uniqueId;
      };
    };

    let newStudent : Student = {
      id = UUID.toText(await g.new());
      firstName = payload.firstName;
      lastName = payload.lastName;
      grade = payload.grade;
      dateOfBirth = payload.dateOfBirth;
      imageId;
    };

    studentsMap.put(schoolId, List.push(newStudent, studentsList));

    return #ok();
  };

  public func addStudent(schoolId : Text, payload : AddStudentPayload) : async () {
    ignore _addStudent(schoolId, payload);
  };

  private func _createDonation(payload : CreateDonationPayload, status : DonationStatus, transactionId : ?Text) : async* Result.Result<CreateDonationResponse, Text> {
    if (Nat64.less(payload.amount, 1) == true) return #err("Amount must be more than 0 satoshi.");

    let paymentAddress = await BitcoinIntegration.generateNextPaymentAddress(ownerExtendedPublicKeyBase58Check, currentChildKeyIndex);

    currentChildKeyIndex := currentChildKeyIndex + 1;

    switch (paymentAddress) {
      case (#err(msg)) {
        return #err("Error occured when generating payment address.");
      };
      case (#ok(paymentAddress)) {
        let donationId = UUID.toText(await g.new());

        let newDonation : Donation = {
          donationId;
          paymentAddress;
          schoolId = payload.schoolId;
          studentId = payload.studentId;
          amount = payload.amount;
          status;
          allocations = payload.allocations;
          transactionId;
        };

        donationsMap.put(donationId, donations.size());
        donations.add(newDonation);

        return #ok({ donationId; paymentAddress });
      };
    };
  };

  public func createDonation(payload : CreateDonationPayload) : async Result.Result<CreateDonationResponse, Text> {
    await* _createDonation(payload, #Pending, null);
  };

  public func verifyDonation(payload : VerifyDonationPayload) : async Result.Result<(), Text> {
    let ?donationIndex = donationsMap.get(payload.donationId) else return #err("Donation is not found by provided ID.");

    let currentDonation = donations.get(donationIndex);

    let isTransactionConfirmed = await BitcoinIntegration.checkIfTransactionIsConfirmed(currentDonation.paymentAddress, payload.transactionId, currentDonation.amount);

    if (isTransactionConfirmed == false) return #err("Transaction is not verified.");

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

    return #ok();
  };

  // -------------------------------------

  private func storeBlobImg(imgId : Text, value : Blob) {
    var size : Nat = Nat32.toNat(Nat32.fromIntWrap(value.size()));
    // Each page is 64KiB (65536 bytes)
    var growBy : Nat = size / 65536 + 1;
    let a = StableMemory.grow(Nat64.fromNat(growBy));
    StableMemory.storeBlob(currentMemoryOffset, value);
    imgOffset.put(imgId, currentMemoryOffset);
    imgSize.put(imgId, size);
    size := size + 4;
    currentMemoryOffset += Nat64.fromNat(size);
  };

  private func loadBlobImg(imgId : Text) : ?Blob {
    let offset = imgOffset.get(imgId);
    switch (offset) {
      case (null) {
        return null;
      };
      case (?offset) {
        let size = imgSize.get(imgId);
        switch (size) {
          case (null) {
            return null;
          };
          case (?size) {
            return ?StableMemory.loadBlob(offset, size);
          };
        };
      };
    };
  };

  public query func httpRequest(request : HttpRequest) : async HttpResponse {
    if (Text.contains(request.url, #text("imgid"))) {
      let imageId = Iter.toArray(Text.tokens(request.url, #text("imgid=")))[1];
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

  /// -------------------------------------

  private func reset() : async* () {
    schools.clear();
    donations.clear();

    for ((id, value) in studentsMap.entries()) {
      ignore studentsMap.remove(id);
    };
    for ((id, value) in donationsMap.entries()) {
      ignore donationsMap.remove(id);
    };
    for ((id, value) in imgOffset.entries()) {
      ignore imgOffset.remove(id);
    };
  };

  // --------------------------------------
  // --------------------------------------
  // --------------------------------------
  // --------------------------------------
  // --------------------------------------
  // --------------------------------------

  public func mockData() : async () {
    await* reset();
    // Add schools
    await* _addSchool({
      name = "Kyiv International School";
      location = "Ukraine, Kyiv";
      website = "https://kyiv.qsi.org/";
      imageBlob = null;
    });
    await* _addSchool({
      name = "Kharkiv Specialized School №156";
      location = "Ukraine, Kharkiv";
      website = "http://school156.edu.kh.ua/";
      imageBlob = null;
    });
    await* _addSchool({
      name = "Kharkivsʹka Himnaziya No 116";
      location = "Ukraine, Kharkiv";
      website = "http://gymnasium116.edu.kh.ua/";
      imageBlob = null;
    });
    await* _addSchool({
      name = "Odessa High School";
      location = "Ukraine, Odessa";
      website = "https://www.odessahs.org/";
      imageBlob = null;
    });

    let names = ["John", "Alex", "James", "Mike", "Justin", "Bob", "Kevin", "Luka"];
    let surNames = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis"];
    let dateOfBirthdays = ["2001-01-01", "2002-02-02", "2003-03-03", "2004-04-04", "2005-05-05", "2006-06-06", "2007-07-07", "2008-08-08"];
    let grades = ["1a", "2b", "3c", "4d", "5b", "6a", "7d", "8c"];

    let schoolIds = Array.map<School, Text>(Vector.toArray(schools), func school = school.id);

    var counter = 0;

    for (index in Iter.range(0, schoolIds.size() - 1)) {
      for (_ in Iter.range(0, 7)) {
        let studentObj : AddStudentPayload = {
          firstName = names[counter % names.size()];
          lastName = surNames[counter % surNames.size()];
          grade = grades[counter % grades.size()];
          dateOfBirth = dateOfBirthdays[counter % dateOfBirthdays.size()];
          imageBlob = null;
        };

        counter := counter + 1;

        ignore await* _addStudent(schoolIds[index], studentObj);
      };
    };

    await* mockDonationsData();

  };

  private func mockDonationsData() : async* () {
    let schoolIds = Array.map<School, Text>(Vector.toArray(schools), func school = school.id);

    var counter = 1;

    var amountVariants : [Nat] = [20002001, 240002001, 60400200, 90000000];
    let allocationAmounts = [25, 38, 30, 17];

    for (index in Iter.range(0, schoolIds.size() - 1)) {
      let studentList = studentsMap.get(schoolIds.get(index));

      switch (studentList) {
        case null {};
        case (?list) {
          for (idx in Iter.range(0, List.size(list) - 1)) {
            ignore await* _createDonation(
              {
                schoolId = schoolIds[index];
                amount = Nat64.fromNat(amountVariants[(counter % amountVariants.size())]);
                studentId = switch (List.get(list, idx)) {
                  case null { null };
                  case (?val) { ?val.id };
                };
                allocations = [
                  #DesignAndDevelopment(allocationAmounts[counter % 4]),
                  #TeacherSupport(allocationAmounts[(counter + 1) % 4]),
                  #SchoolSupplies(allocationAmounts[(counter + 2) % 4]),
                  #LunchAndSnacks(allocationAmounts[(counter + 3) % 4]),
                ];
              },
              #Verified,
              ?BitcoinIntegrationUtils.bytesToText([
                (Nat8.fromNat(counter * 10 % 255)),
                (Nat8.fromNat(counter * 20 % 255)),
                (Nat8.fromNat(counter * 30 % 255)),
                (Nat8.fromNat(counter * 40 % 255)),
                (Nat8.fromNat(counter * 50 % 255)),
              ]),
            );

            counter := counter + 1;
          };
        };
      };

      ignore await* _createDonation(
        {
          schoolId = schoolIds[index];
          amount = Nat64.fromNat(amountVariants[(counter % amountVariants.size())]);
          studentId = null;
          allocations = [
            #DesignAndDevelopment(allocationAmounts[counter % 4]),
            #TeacherSupport(allocationAmounts[(counter + 1) % 4]),
            #SchoolSupplies(allocationAmounts[(counter + 2) % 4]),
            #LunchAndSnacks(allocationAmounts[(counter + 3) % 4]),
          ];
        },
        #Verified,
        ?BitcoinIntegrationUtils.bytesToText([
          (Nat8.fromNat(counter * 10 % 255)),
          (Nat8.fromNat(counter * 20 % 255)),
          (Nat8.fromNat(counter * 30 % 255)),
          (Nat8.fromNat(counter * 40 % 255)),
          (Nat8.fromNat(counter * 50 % 255)),
        ]),
      );

      counter := counter + 1;

    };
  };

  // --------------------------------------
  // --------------------------------------
  // --------------------------------------

  system func preupgrade() {
    stableSchools := schools.share();
    stableStudentsMap := studentsMap.share();
    stableDonations := donations.share();
    stableDonationsMap := donationsMap.share();
    stableImgOffset := imgOffset.share();
  };

  system func postupgrade() {
    schools.unshare(stableSchools);
    studentsMap.unshare(stableStudentsMap);
    donations.unshare(stableDonations);
    donationsMap.unshare(stableDonationsMap);
    imgOffset.unshare(stableImgOffset);
  };
};
