import type { School, Student } from "../../declarations/backend/backend.did";
import type { DonationFormError, DonationFormValues, GridItem } from "./types";

export function mapSchoolsToGridItems(schools: School[]): GridItem[] {
  return schools.map((school) => {
    return {
      id: school.id,
      name: school.name,
      image: "",
      description: school.website,
    };
  });
}

export function mapStudentsToGridItems(students: Student[]): GridItem[] {
  return students.map((student) => {
    return {
      id: student.id,
      name: student.firstName + " " + student.lastName,
      image: "",
      description: `Grade: ${student.grade}, ${student.dateOfBirth}`,
    };
  });
}

export function validateDonationForm(values: DonationFormValues) {
  const errors = {} as DonationFormError;

  errors.budgetError = Number(values.totalAmount) <= 0;

  const totalPercentage = values.categories.reduce(
    (acc, category) => acc + Number(category.percent),
    0
  );

  if (totalPercentage !== 100) {
    errors.categoryAllocation = true;
  }

  return errors;
}
