import type { UploadedFile } from "$lib/common/types";
import { Principal } from "@dfinity/principal";
import { type DateValue } from "@internationalized/date";

export interface FormAdminSchool {
  id: string;
  name: string;
  website: string;
  location: string;
  numberOfStudents: number;
  images: Array<File & UploadedFile>;
  active: boolean;
}

export interface FormAdminStudent {
  id: string;
  firstName: string;
  lastName: string;
  dateOfBirth: DateValue | null;
  grade: string;
  active: boolean;
  images: Array<File & UploadedFile>;
}

export interface FormAdminPrincipal {
  id: string;
  principal: Principal;
}
