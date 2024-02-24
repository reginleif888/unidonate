import { getImageLink } from "$lib/common/utils";
import type { Student } from "../../../declarations/backend/backend.did";
import type { FormStudent } from "../types";

export default function studentToForm(student: Student): FormStudent {
  return {
    id: student.id,
    firstName: student.firstName,
    lastName: student.lastName,
    dateOfBirth: student.dateOfBirth,
    grade: student.grade,
    imgs: (student.images[0] ?? []).map((img) => getImageLink(img.id)),
  };
}
