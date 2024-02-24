import { getImageLink } from "$lib/common/utils";
import type { School } from "../../../declarations/backend/backend.did";
import type { FormSchool } from "../types";

export default function studentToForm(school: School): FormSchool {
  return {
    id: school.id,
    name: school.name,
    website: school.website,
    location: school.location,
    numberOfStudents: school.students.length,
    imgs: (school.images[0] ?? []).map((img) => getImageLink(img.id)),
  };
}
