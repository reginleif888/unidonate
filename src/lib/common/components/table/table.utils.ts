import type { Column } from "./table.types";

export function columnsToMap(columns: Array<Column>) {
  return columns.reduce((acc: Record<string, Column>, column) => {
    acc[column.key] = column;

    return acc;
  }, {});
}
