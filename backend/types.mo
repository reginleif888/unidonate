import Vector "mo:vector/Class";
import RBTree "mo:base/RBTree";
import List "mo:base/List";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";

import BitcoinIntegration "bitcoin-integration";

module {
  type Satoshi = BitcoinIntegration.Satoshi;

  public type School = {
    id : Text;
    name : Text;
    location : Text;
    website : Text;
    students : [Text];
    images : ?[ClientImageObject];
    active : Bool;
  };

  public type Student = {
    id : Text;
    firstName : Text;
    lastName : Text;
    grade : Text;
    dateOfBirth : Text;
    images : ?[ClientImageObject];
    schoolId : Text;
    active : Bool;
  };

  public type ImageObject = {
    id : Text;
    offset : Nat64;
    size : Nat;
    name : Text;
    mimeType : Text;
    isDeleted : Bool;
  };

  public type UploadImagePayload = {
    id : ?Text;
    name : Text;
    mimeType : Text;
    data : Blob;
  };

  public type ClientImageObject = {
    name : Text;
    mimeType : Text;
    id : Text;
  };

  public type AddSchoolPayload = {
    name : Text;
    location : Text;
    website : Text;
    images : ?[UploadImagePayload];
  };

  public type UpdateSchoolPayload = {
    name : ?Text;
    location : ?Text;
    website : ?Text;
    images : ?[UploadImagePayload];
    active : ?Bool;
  };

  public type AddStudentPayload = {
    firstName : Text;
    lastName : Text;
    grade : Text;
    dateOfBirth : Text;
    images : ?[UploadImagePayload];
  };

  public type UpdateStudentPayload = {
    firstName : ?Text;
    lastName : ?Text;
    grade : ?Text;
    dateOfBirth : ?Text;
    images : ?[UploadImagePayload];
    active : ?Bool;
  };

  public type SchoolsFilters = {
    schoolName : Text;
    active : Bool;
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

  public type StudentsFilters = {
    studentName : Text;
    active : Bool;
  };

  public type GetStudentsPayload = {
    filters : StudentsFilters;
    page : Nat;
    perPage : Nat;
  };

  public type GetStudentsResponse = {
    students : [Student];
    total : Nat;
  };

  public type DonationSortingField = {
    #verifiedAt;
    #amount;
  };

  public type DonationSortingOrder = {
    #ascending;
    #descending;
  };

  public type DonationsSorting = {
    field : DonationSortingField;
    order : DonationSortingOrder;
  };

  public type GetDonationsPayload = {
    sorting : ?DonationsSorting;
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
    verifiedAt : ?Int;
  };

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
