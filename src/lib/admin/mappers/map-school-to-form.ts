import type { UploadedFile } from "$lib/common/types";
import type { School } from "../../../declarations/backend/backend.did";
import type { FormAdminSchool } from "../types";

export default function mapSchoolToForm(school: School): FormAdminSchool {
  return {
    id: school.id,
    name: school.name,
    website: school.website,
    location: school.location,
    active: school.active,
    numberOfStudents: school.students.length as unknown as number,
    images: (school.images[0] ?? []).map((image) => ({
      id: image.id,
      mimeType: image.mimeType,
      name: image.name,
    })) as Array<File & UploadedFile>,
  };
}
