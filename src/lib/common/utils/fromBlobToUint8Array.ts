interface FormBlobToUint8ArrayParams {
  files: Array<File>;
}

export default function filesToUint8Arrays({
  files,
}: FormBlobToUint8ArrayParams): Promise<Uint8Array[]> {
  const promises = files.map((file) => {
    return new Promise<Uint8Array>((resolve, reject) => {
      const reader = new FileReader();

      reader.onload = function (event) {
        const arrayBuffer = event.target?.result as ArrayBuffer;

        const uint8Array = new Uint8Array(arrayBuffer);

        resolve(uint8Array);
      };

      reader.onerror = function () {
        reject(reader.error);
      };

      reader.readAsArrayBuffer(file);
    });
  });

  return Promise.all(promises);
}
