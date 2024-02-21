import * as XLSX from "xlsx";

export interface ColumnMapping {
  index: number;
  fieldName: string;
}

export interface XlsxToJsonParams {
  file: File;
  columnMapping: ColumnMapping[];
}

const xlsxToJson = async ({
  file,
  columnMapping,
}: XlsxToJsonParams): Promise<any[]> => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = (e: ProgressEvent<FileReader>) => {
      try {
        const data = e.target?.result;
        const workbook = XLSX.read(data, { type: "binary" });
        const sheetName = workbook.SheetNames[0];
        const worksheet = workbook.Sheets[sheetName];
        const jsonOptions = { header: 1, defval: "" };
        const jsonData: any[] = XLSX.utils.sheet_to_json(
          worksheet,
          jsonOptions
        );

        const mappedData = jsonData.map((row: any[]) => {
          let obj: { [key: string]: any } = {};
          columnMapping.forEach((column) => {
            const value = row[column.index];
            if (value !== undefined) {
              obj[column.fieldName] = value;
            }
          });
          return obj;
        });

        resolve(mappedData.slice(1));
      } catch (error) {
        reject(error);
      }
    };
    reader.onerror = (error) => reject(error);
    reader.readAsBinaryString(file);
  });
};

export default xlsxToJson;
