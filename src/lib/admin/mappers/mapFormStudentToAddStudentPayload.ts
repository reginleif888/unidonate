import { formatToISODateString } from "$lib/common/utils";
import filesToUint8Arrays from "$lib/common/utils/fromBlobToUint8Array";
import type {
  ImageObject,
  AddStudentPayload,
} from "../../../declarations/backend/backend.did";
import type { FormAdminStudent } from "../types";

export default async function mapFormStudentToAddStudentPayload(
  formStudent: FormAdminStudent
): Promise<AddStudentPayload> {
  const mappedImages: Array<ImageObject> = [];

  for (const image of formStudent.images) {
    const [mappedImage] = await filesToUint8Arrays({ files: [image] });

    mappedImages.push({
      id: [],
      mimeType: image.type,
      name: image.name,
      data: mappedImage,
    });
  }

  return {
    firstName: formStudent.firstName,
    lastName: formStudent.lastName,
    dateOfBirth: formatToISODateString(formStudent.dateOfBirth!),
    grade: formStudent.grade,
    images: [mappedImages],
  };
}
