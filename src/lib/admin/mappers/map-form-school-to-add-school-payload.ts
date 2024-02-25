import filesToUint8Arrays from "$lib/common/utils/from-blob-to-uint-8-array";
import type {
  ImageObject,
  AddSchoolPayload,
} from "../../../declarations/backend/backend.did";
import type { FormAdminSchool } from "../types";
import changeImageExtension from "../utils/change-image-extenstion";

export default async function mapFormSchoolToAddSchoolPayload(
  formSchool: FormAdminSchool
): Promise<AddSchoolPayload> {
  const mappedImages: Array<ImageObject> = [];

  for (const image of formSchool.images) {
    const [mappedImage] = await filesToUint8Arrays({ files: [image] });

    mappedImages.push({
      id: [],
      mimeType: image.type,
      name: changeImageExtension(image.name),
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
