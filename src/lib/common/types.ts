import type { SvelteComponent } from "svelte";

export type UniqueIdentifier = string;

export type DoughnutChartDataItem = {
  value: number;
  color: string;
  label: string;
  id: UniqueIdentifier;
};

export interface SelectItem {
  value: UniqueIdentifier;
  label?: string;
  Icon?: typeof SvelteComponent<any>;
  disabled?: boolean;
}

export interface StepItem {
  label: string;
  value: UniqueIdentifier;
  Icon: typeof SvelteComponent<any>;
  img?: string;
  useImgInsteadOfIcon?: boolean;
  disabled?: boolean;
  optional?: boolean;
}
