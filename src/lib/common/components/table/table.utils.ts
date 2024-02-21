import type { UniqueIdentifier } from "$lib/common/types";
import type { Column, Row } from "./table.types";

export function columnsToMap<TRow extends Row<UniqueIdentifier>>(
  columns: Array<Column<TRow>>
) {
  return columns.reduce(
    (acc, column) => {
      acc[column.key] = column;

      return acc;
    },
    {} as Record<keyof TRow, Column<TRow>>
  );
}
