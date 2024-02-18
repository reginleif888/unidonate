import type { UniqueIdentifier } from "$lib/common/types";
import type { SvelteComponent } from "svelte";

export type ColumnAlign = "right" | "left" | "center";

export interface Column {
  key: string;
  label: string;
  minWidth?: number;
  align?: ColumnAlign;
  format?: (value: string) => string;
  Cell?: typeof SvelteComponent<any>;
}

export interface Row<T extends UniqueIdentifier> {
  id: UniqueIdentifier;
  [key: string]: any;
}
