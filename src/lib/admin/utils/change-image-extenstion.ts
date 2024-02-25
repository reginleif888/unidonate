export default function changeImageExtension(
  fileName: string,
  newExtension: string = "webp"
): string {
  const lastIndex = fileName.lastIndexOf(".");

  if (lastIndex < 1) {
    return `${fileName}.${newExtension}`;
  }

  return `${fileName.substring(0, lastIndex)}.${newExtension}`;
}
