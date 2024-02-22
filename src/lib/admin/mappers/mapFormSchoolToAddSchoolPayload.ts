import filesToUint8Arrays from "$lib/common/utils/fromBlobToUint8Array";
import type {
  ImageObject,
  AddSchoolPayload,
} from "../../../declarations/backend/backend.did";
import type { FormAdminSchool } from "../types";

export default async function mapFormSchoolToAddSchoolPayload(
  formSchool: FormAdminSchool
): Promise<AddSchoolPayload> {
  const mappedImages: Array<ImageObject> = [];

  for (const image of formSchool.images) {
    const [mappedImage] = await filesToUint8Arrays({ files: [image] });

    mappedImages.push({
      id: [],
      mimeType: image.type,
      name: image.name,
      data: mappedImage,
    });
  }

  return {
    name: formSchool.name,
    website: formSchool.website,
    location: formSchool.location,
    images: [mappedImages],
  };
}
