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

import BitcoinIntegration "bitcoin-integration";

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

  type Donation = Types.Donation;
  type DonationsList = Types.DonationsList;
  type CreateDonationPayload = Types.CreateDonationPayload;
  type CreateDonationResponse = Types.CreateDonationResponse;

  let g = Source.Source();

  // --------------------------------------

  let schools : SchoolsList = Vector.Vector<Types.School>();
  stable var stableSchools = schools.share();

  let studentsMap : StudentsListsMap = RBTree.RBTree<Text, List.List<Student>>(Text.compare);
  stable var stableStudentsMap = studentsMap.share();

  let donations : DonationsList = Vector.Vector<Donation>();
  stable var stableDonations = donations.share();

  // Fot testing
  private stable let ownerExtendedPublicKeyBase58Check : Text = "tpubDD9S94RYo2MraS7QbRhA64Nr56BzCYN2orJUkk2LE4RkB2npb9SFyiCuofbapC9wNW2hLJqkWwSpGoaE9pZC6fLBQdms5HYS9dsvw79nSWy";
  private stable var currentChildKeyIndex : Nat = 0;

  // --------------------------------------

  public query func getSchools({ filters; page; perPage } : GetSchoolsPayload) : async GetSchoolsResponse {
    let total = schools.size();

    var filteredSchoolsList = schools;

    if (Text.size(filters.schoolName) > 0) {
      filteredSchoolsList := Vector.Vector<School>();

      for (index in Iter.range(0, total)) {
        let school = schools.get(index);

        if (Text.contains(school.name, #text(filters.schoolName))) {
          filteredSchoolsList.add(schools.get(index));
        };
      };
    };

    let filteredSize = filteredSchoolsList.size();

    let startIndex = Nat.min(filteredSize - 1, page * perPage);
    let endIndex = Nat.min(filteredSize - 1, (page + 1) * perPage);

    let paginatedSchools = Vector.Vector<School>();

    for (index in Iter.range(startIndex, endIndex)) {
      paginatedSchools.add(filteredSchoolsList.get(index));
    };

    let response : GetSchoolsResponse = {
      schools = Vector.toArray(paginatedSchools);
      total;
    };
    return response;
  };

  public func addSchool(payload : AddSchoolPayload) : async () {
    let schoolId = UUID.toText(await g.new());

    let newSchool : School = {
      id = schoolId;
      name = payload.name;
      location = payload.location;
      website = payload.website;
      numberOfStudents = 0;
    };

    schools.add(newSchool);
    studentsMap.put(newSchool.id, null);
  };

  public query func getStudents(schoolId : Text) : async Result.Result<[Student], Text> {
    let ?studentsList = studentsMap.get(schoolId) else return #err("School is not found by provided ID.");
    return #ok(List.toArray<Student>(studentsList));
  };

  public func addStudent(schoolId : Text, payload : AddStudentPayload) : async Result.Result<(), Text> {
    let ?studentsList = studentsMap.get(schoolId) else return #err("School is not found by provided ID.");

    let newStudent : Student = {
      id = UUID.toText(await g.new());
      firstName = payload.firstName;
      lastName = payload.lastName;
      grade = payload.grade;
      dateOfBirth = payload.dateOfBirth;
    };

    studentsMap.put(schoolId, List.push(newStudent, studentsList));

    return #ok();
  };

  public func createDonation(payload : CreateDonationPayload) : async Result.Result<CreateDonationResponse, Text> {
    if (Nat64.less(payload.amount, 1) == true) return #err("Amount must be more than 0 satoshi.");

    let paymentAddress = await BitcoinIntegration.generateNextPaymentAddress(ownerExtendedPublicKeyBase58Check, currentChildKeyIndex);

    switch (paymentAddress) {
      case (#err(msg)) {
        return #err("Error occured when generating payment address.");
      };
      case (#ok(paymentAddress)) {
        let donationId = Int.toText(Time.now());

        let newDonation : Donation = {
          donationId;
          paymentAddress;
          schoolId = payload.schoolId;
          studentId = payload.studentId;
          amount = payload.amount;
          status = #Pending;
          allocations = payload.allocations;
          transactionId = null;
        };

        donations.add(newDonation);

        return #ok({ donationId; paymentAddress });
      };
    };

  };

  // --------------------------------------
  // --------------------------------------
  // --------------------------------------

  system func preupgrade() {
    stableSchools := schools.share();
    stableStudentsMap := studentsMap.share();
    stableDonations := donations.share();
  };

  system func postupgrade() {
    schools.unshare(stableSchools);
    studentsMap.unshare(stableStudentsMap);
    donations.unshare(stableDonations);
  };
};
