export interface FormAdminSchool {
  id: string;
  name: string;
  website: string;
  img: string;
  location: string;
  numberOfStudents: number;
}

export interface FormAdminStudent {
  id: string;
  firstName: string;
  lastName: string;
  dateOfBirth: string;
  grade: string;
  img: string;
}
