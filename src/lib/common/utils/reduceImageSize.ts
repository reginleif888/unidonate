export default async function reduceImageSize(
  blob: Blob,
  maxWidth: number = 800,
  maxHeight: number = 600
): Promise<Blob> {
  const img = await createImageFromBlob(blob);
  const canvas = resizeImageOnCanvas(img, maxWidth, maxHeight);
  const reducedBlob = await convertCanvasToBlob(canvas);
  return reducedBlob;
}

async function convertCanvasToBlob(
  canvas: HTMLCanvasElement,
  quality: number = 0.75
): Promise<Blob> {
  return new Promise((resolve) => {
    canvas.toBlob(
      (blob) => {
        if (!blob) throw new Error("Canvas to Blob conversion failed");
        resolve(blob);
      },
      "image/webp",
      quality
    );
  });
}

async function createImageFromBlob(blob: Blob): Promise<HTMLImageElement> {
  return new Promise((resolve, reject) => {
    const url = URL.createObjectURL(blob);
    const img = new Image();
    img.onload = () => {
      URL.revokeObjectURL(url);
      resolve(img);
    };
    img.onerror = (e) => {
      reject(e);
    };
    img.src = url;
  });
}

function resizeImageOnCanvas(
  img: HTMLImageElement,
  maxWidth: number = 800,
  maxHeight: number = 600
): HTMLCanvasElement {
  const canvas = document.createElement("canvas");
  let width = img.width;
  let height = img.height;

  if (width > height) {
    if (width > maxWidth) {
      height *= maxWidth / width;
      width = maxWidth;
    }
  } else {
    if (height > maxHeight) {
      width *= maxHeight / height;
      height = maxHeight;
    }
  }

  canvas.width = width;
  canvas.height = height;

  const ctx = canvas.getContext("2d");
  if (!ctx) throw new Error("Unable to get canvas context");
  ctx.drawImage(img, 0, 0, width, height);
  return canvas;
}
