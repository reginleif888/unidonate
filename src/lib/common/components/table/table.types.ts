import type { UniqueIdentifier } from "$lib/common/types";
import type { SvelteComponent } from "svelte";

export type ColumnAlign = "right" | "left" | "center";

export interface Row<T extends UniqueIdentifier> {
  id: T;
  [key: string]: any;
}

export interface Column<TRow extends Row<UniqueIdentifier>> {
  key: keyof TRow;
  label: string;
  minWidth?: number;
  align?: ColumnAlign;
  format?: (value: TRow[keyof TRow] | any, origin: TRow) => string; // Using any to bypass strict typing
  Cell?: typeof SvelteComponent<any>;
}
