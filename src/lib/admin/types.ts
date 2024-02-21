import type { Image, UploadedFile } from "$lib/common/types";

export interface FormAdminSchool {
  id: string;
  name: string;
  website: string;
  location: string;
  numberOfStudents: number;
  images: Array<File & UploadedFile>;
}

export interface FormAdminStudent {
  id: string;
  firstName: string;
  lastName: string;
  dateOfBirth: string;
  grade: string;
  images: Array<any>;
}
