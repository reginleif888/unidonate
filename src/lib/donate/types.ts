import type { SvelteComponent } from "svelte";

export interface GridItem {
  id: string;
  name: string;
  image: string;
  description: string;
}

export interface FormCategory {
  categoryId: string;
  percent: number;
}

export enum DonationStep {
  School = "School",
  Student = "Student",
  DonationAllocation = "DonationAllocation",
}

export interface FormSchool {
  id: string;
  name: string;
  website: string;
  location: string;
  numberOfStudents: number;
  imgs: Array<string>;
}

export interface FormStudent {
  id: string;
  firstName: string;
  lastName: string;
  dateOfBirth: string;
  grade: string;
  imgs: Array<string>;
}

export enum EntityType {
  School = "School",
  Student = "Student",
}

export interface EntityTypeValue {
  title: string;
  subtitle: string;
  searchPlaceholder: string;
  Component: typeof SvelteComponent<any>;
}

export enum AllocationCategory {
  LunchAndSnacks = "LunchAndSnacks",
  SchoolSupplies = "SchoolSupplies",
  DesignAndDevelopment = "DesignAndDevelopment",
  TeacherSupport = "TeacherSupport",
}

export type MapAllocationCategoryValue = {
  label: string;
  color: string;
  text: string;
  emoji: string;
};

export interface DonationFormValues {
  categories: Record<string, number>;
  satoshi: number | null;
}

export interface DonationError {
  satoshi: boolean;
  message: string;
  biggestCategory?: AllocationCategory;
  client?: boolean;
}

export interface PaginationFilter {
  search: string;
  perPage: number;
  page: number;
}
