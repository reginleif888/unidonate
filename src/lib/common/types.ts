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

export interface Snackbar {
  id: UniqueIdentifier;
  message: string;
  type: "success" | "error";
  timeout: number;
}

export type TooltipSide = "top" | "bottom" | "left" | "right";

export interface TabRoute {
  route: string;
  label: string;
  Icon: typeof SvelteComponent<any>;
}
