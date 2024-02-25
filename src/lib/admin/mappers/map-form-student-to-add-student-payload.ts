import { formatToISODateString } from "$lib/common/utils";
import filesToUint8Arrays from "$lib/common/utils/from-blob-to-uint-8-array";
import type {
  UploadImagePayload,
  AddStudentPayload,
} from "../../../declarations/backend/backend.did";
import type { FormAdminStudent } from "../types";
import changeImageExtension from "../utils/change-image-extenstion";

export default async function mapFormStudentToAddStudentPayload(
  formStudent: FormAdminStudent
): Promise<AddStudentPayload> {
  const mappedImages: Array<UploadImagePayload> = [];

  for (const image of formStudent.images) {
    const [mappedImage] = await filesToUint8Arrays({ files: [image] });

    mappedImages.push({
      id: [],
      mimeType: image.type,
      name: changeImageExtension(image.name),
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
