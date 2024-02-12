import type { SvelteComponent } from "svelte";

export type PicChartDataItem = {
  value: number;
  color: string;
  label: string;
};

export enum AllocationCategory {
  LunchAndSnacks = "LunchAndSnacks",
  SchoolSupplies = "SchoolSupplies",
  DesignAndDevelopment = "DesignAndDevelopment",
  TeacherSupport = "TeacherSupport",
}

export type UniqueIdentifier = string;

export interface SelectItem {
  value: UniqueIdentifier;
  label?: string;
  Icon?: typeof SvelteComponent<any>;
  disabled?: boolean;
}
