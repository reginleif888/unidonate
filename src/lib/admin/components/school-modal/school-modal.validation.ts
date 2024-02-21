import type { FormAdminSchool } from "$lib/admin/types";
import { isValidWebsite } from "$lib/common/utils/validation";

export function validation(values: FormAdminSchool): Record<string, any> {
  const errors = {} as Record<keyof FormAdminSchool, string>;

  if (!values.name) {
    errors.name = "Name is required";
  }

  if (!values.location) {
    errors.location = "Location is required";
  }

  if (values.website && !isValidWebsite(values.website)) {
    errors.website = "Invalid website";
  }

  if (!values.website) {
    errors.website = "Website is required";
  }

  return errors;
}
