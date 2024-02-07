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
    imageId : ?Text;
  };

  public type Student = {
    id : Text;
    firstName : Text;
    lastName : Text;
    grade : Text;
    dateOfBirth : Text;
    imageId : ?Text;
  };

  public type SchoolsList = Vector.Vector<School>;
  public type StudentsList = List.List<Student>;
  public type StudentsListsMap = RBTree.RBTree<Text, StudentsList>;

  public type AddSchoolPayload = {
    name : Text;
    location : Text;
    website : Text;
    imageBlob : ?Blob;
  };

  public type AddStudentPayload = {
    firstName : Text;
    lastName : Text;
    grade : Text;
    dateOfBirth : Text;
    imageBlob : ?Blob;
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

  public type DonationsFilters = {
    donationId : Text;
  };

  public type GetDonationsPayload = {
    filters : DonationsFilters;
    page : Nat;
    perPage : Nat;
  };

  public type GetDonationsResponse = {
    donations : [Donation];
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
    paymentAddress : Text;
    schoolId : Text;
    studentId : ?Text;
    transactionId : ?Text;
    amount : Satoshi;
    status : DonationStatus;
    allocations : [AllocationCategory];
  };

  public type DonationsList = Vector.Vector<Donation>;

  public type DonationsMap = RBTree.RBTree<Text, Nat>;

  public type CreateDonationPayload = {
    schoolId : Text;
    studentId : ?Text;
    amount : Satoshi;
    allocations : [AllocationCategory];
  };

  public type CreateDonationResponse = {
    donationId : Text;
    paymentAddress : Text;
  };

  public type VerifyDonationPayload = {
    donationId : Text;
    transactionId : Text;
  };

  public type HeaderField = (Text, Text);

  public type StreamingStrategy = {
    #Callback : {
      callback : StreamingCallback;
      token : StreamingCallbackToken;
    };
  };

  public type StreamingCallback = query (StreamingCallbackToken) -> async (StreamingCallbackResponse);

  public type StreamingCallbackToken = {
    content_encoding : Text;
    index : Nat;
    key : Text;
  };

  public type StreamingCallbackResponse = {
    body : Blob;
    token : ?StreamingCallbackToken;
  };

  public type HttpRequest = {
    body : Blob;
    headers : [HeaderField];
    method : Text;
    url : Text;
  };

  public type HttpResponse = {
    body : Blob;
    headers : [HeaderField];
    streaming_strategy : ?StreamingStrategy;
    status_code : Nat16;
  };
};
