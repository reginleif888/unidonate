import filesToUint8Arrays from "$lib/common/utils/fromBlobToUint8Array";
import type {
  ImageObject,
  UpdateSchoolPayload,
} from "../../../declarations/backend/backend.did";
import type { FormAdminSchool } from "../types";
import changeImageExtension from "../utils/changeImageExtenstion";

export default async function mapFormSchoolToUpdateSchoolPayload(
  formSchool: FormAdminSchool
): Promise<UpdateSchoolPayload> {
  const mappedImages: Array<ImageObject> = [];

  for (const image of formSchool.images) {
    if (!image.id) {
      const [mappedImage] = await filesToUint8Arrays({ files: [image] });

      mappedImages.push({
        id: [],
        mimeType: image.mimeType ?? image.type,
        name: changeImageExtension(image.name),
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
    active: [formSchool.active],
    name: [formSchool.name],
    website: [formSchool.website],
    location: [formSchool.location],
    images: [mappedImages],
  };
}
