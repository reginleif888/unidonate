import type { FormAdminStudent } from "$lib/admin/types";
import { isValidBirthDay } from "$lib/common/utils/validation";

export function validation(values: FormAdminStudent): Record<string, any> {
  const errors = {} as Record<keyof FormAdminStudent, string>;

  if (!values.firstName) {
    errors.firstName = "First name is required";
  }

  if (!values.lastName) {
    errors.lastName = "Last name is required";
  }

  if (!values.grade) {
    errors.grade = "Grade is required";
  }

  if (
    !values.dateOfBirth ||
    (values.dateOfBirth && !isValidBirthDay(values.dateOfBirth))
  ) {
    errors.dateOfBirth = "Date of birth is not valid";
  }

  return errors;
}
