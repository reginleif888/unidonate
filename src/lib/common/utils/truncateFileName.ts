interface TruncateFileNameParams {
  file: File;
  maxLength: number;
}

interface TruncateFileNameReturn {
  name: string;
  truncated: boolean;
}

export default function truncateFileName({
  file,
  maxLength,
}: TruncateFileNameParams): TruncateFileNameReturn {
  const fullFileName = file.name;
  const extension = fullFileName.slice(fullFileName.lastIndexOf("."));
  const nameWithoutExtension = fullFileName.substring(
    0,
    fullFileName.lastIndexOf(".")
  );

  let truncated = false;
  let truncatedName = fullFileName;

  if (nameWithoutExtension.length > maxLength) {
    truncatedName = `${nameWithoutExtension.substring(0, maxLength - 3)}...${extension}`;
    truncated = true;
  }

  return { name: truncatedName, truncated };
}
