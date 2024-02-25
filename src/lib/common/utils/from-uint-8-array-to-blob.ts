interface Uint8ArraysToFilesParams {
  array: Uint8Array[];
}

export default function uint8ArraysToFiles({
  array,
}: Uint8ArraysToFilesParams): Promise<File[]> {
  return new Promise<File[]>((resolve, reject) => {
    try {
      const files = array.map((data, index) => {
        const blob = new Blob([data]);

        const file = new File([blob], "file");

        return file;
      });

      resolve(files);
    } catch (error) {
      reject(error);
    }
  });
}
