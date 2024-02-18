import type { UniqueIdentifier } from "$lib/common/types";
import type { SvelteComponent } from "svelte";

export interface SelectItem {
  value: UniqueIdentifier;
  label: string;
}

export interface School {
  id: string;
  name: string;
  image: string;
  description: string;
  studentsCount: string;
}

export interface Student {
  id: string;
  name: string;
  age: string;
}

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

export interface DonationFormValues {
  categoryAllocation?: boolean | undefined;
  budgetError?: boolean | undefined;
  totalAmount: number;
  categories: FormCategory[];
}

export type DonationFormError = {
  categoryAllocation?: boolean | undefined;
  budgetError?: boolean | undefined;
};

export enum DonationStep {
  School = "School",
  Student = "Student",
  DonationAllocation = "DonationAllocation",
}

export interface FormSchool {
  id: string;
  name: string;
  website: string;
  img: string;
  location: string;
  numberOfStudents: number;
}

export interface FormStudent {
  id: string;
  firstName: string;
  lastName: string;
  dateOfBirth: string;
  grade: string;
  img: string;
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
