import type { Image } from "$lib/common/types";

export interface FormAdminSchool {
  id: string;
  name: string;
  website: string;
  location: string;
  numberOfStudents: number;
  images: Array<any>;
}

export interface FormAdminStudent {
  id: string;
  firstName: string;
  lastName: string;
  dateOfBirth: string;
  grade: string;
  images: Array<any>;
}
