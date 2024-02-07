import Vector "mo:vector/Class";
import RBTree "mo:base/RBTree";
import List "mo:base/List";
import Nat "mo:base/Nat";

import BitcoinIntegration "bitcoin-integration";

module {
  type Satoshi = BitcoinIntegration.Satoshi;

  public type School = {
    id : Text;
    name : Text;
    location : Text;
    website : Text;
    numberOfStudents : Nat;
  };

  public type Student = {
    id : Text;
    firstName : Text;
    lastName : Text;
    grade : Text;
    dateOfBirth : Text;
  };

  public type SchoolsList = Vector.Vector<School>;
  public type StudentsList = List.List<Student>;
  public type StudentsListsMap = RBTree.RBTree<Text, StudentsList>;

  public type AddSchoolPayload = {
    name : Text;
    location : Text;
    website : Text;
  };

  public type AddStudentPayload = {
    firstName : Text;
    lastName : Text;
    grade : Text;
    dateOfBirth : Text;
  };

  public type SchoolsFilters = {
    schoolName : Text;
  };

  public type GetSchoolsPayload = {
    filters : SchoolsFilters;
    page : Nat;
    perPage : Nat;
  };

  public type GetSchoolsResponse = {
    schools : [School];
    total : Nat;
  };

  public type DonationStatus = {
    #Pending;
    #Verified;
  };

  public type AllocationCategory = {
    #DesignAndDevelopment : Nat;
    #TeacherSupport : Nat;
    #SchoolSupplies : Nat;
    #LunchAndSnacks : Nat;
  };

  public type Donation = {
    donationId : Text;
    schoolId : Text;
    studentId : ?Text;
    transactionId : ?Text;
    amount : Satoshi;
    status : DonationStatus;
    allocations : List.List<AllocationCategory>;
  };

  public type DonationsList = Vector.Vector<Donation>;

  public type CreateDonationPayload = {
    schoolId : Text;
    studentId : ?Text;
    amount : Satoshi;
    allocations : List.List<AllocationCategory>;
  };

  public type CreateDonationResponse = {
    donationId : Text;
    paymentAddress : Text;
  };

  public type VerifyDonationPayload = {
    donationId : Text;
    transactionId : Text;
  };

};
