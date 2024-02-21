import type { FormAdminStudent } from "$lib/admin/types";

export const INITIAL_VALUES: FormAdminStudent = {
  id: "",
  firstName: "",
  lastName: "",
  dateOfBirth: null,
  grade: "",
  images: [],
  active: true,
};
