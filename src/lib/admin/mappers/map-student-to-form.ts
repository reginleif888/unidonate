import type { UploadedFile } from "$lib/common/types";
import { parseDate } from "@internationalized/date";
import type { Student } from "../../../declarations/backend/backend.did";
import type { FormAdminStudent } from "../types";

export default function mapStudentToForm(school: Student): FormAdminStudent {
  return {
    id: school.id,
    firstName: school.firstName,
    lastName: school.lastName,
    dateOfBirth: parseDate(school.dateOfBirth),
    grade: school.grade,
    active: school.active,
    images: (school.images[0] ?? []).map((image) => ({
      id: image.id,
      mimeType: image.mimeType,
      name: image.name,
    })) as Array<File & UploadedFile>,
  };
}
