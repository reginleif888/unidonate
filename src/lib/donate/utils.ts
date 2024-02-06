import type { GridItem, School, Student } from "./types";

export function mapSchoolsToGridItems(schools: School[]): GridItem[] {
  return schools.map((school) => {
    return {
      id: school.id,
      name: school.name,
      image: school.image,
      description: school.description,
    };
  });
}

export function mapStudentsToGridItems(students: Student[]): GridItem[] {
  return students.map((student) => {
    return {
      id: student.id,
      name: student.name,
      image: "",
      description: `Age: ${student.age}`,
    };
  });
}
