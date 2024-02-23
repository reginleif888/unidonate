import { formatToISODateString } from "$lib/common/utils";
import filesToUint8Arrays from "$lib/common/utils/fromBlobToUint8Array";
import type {
  ImageObject,
  UpdateStudentPayload,
} from "../../../declarations/backend/backend.did";
import type { FormAdminStudent } from "../types";

export default async function mapFormSchoolToUpdateSchoolPayload(
  formStudent: FormAdminStudent
): Promise<UpdateStudentPayload> {
  const mappedImages: Array<ImageObject> = [];

  for (const image of formStudent.images) {
    if (!image.id) {
      const [mappedImage] = await filesToUint8Arrays({ files: [image] });

      mappedImages.push({
        id: [],
        mimeType: image.mimeType ?? image.type,
        name: image.name,
        data: mappedImage,
      });
    } else {
      mappedImages.push({
        id: [image.id],
        mimeType: image.mimeType,
        name: image.name,
        data: [],
      });
    }
  }

  return {
    active: [formStudent.active],
    firstName: [formStudent.firstName],
    lastName: [formStudent.lastName],
    dateOfBirth: [formatToISODateString(formStudent.dateOfBirth!)],
    grade: [formStudent.grade],
    images: [mappedImages],
  };
}
