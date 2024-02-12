import { AllocationCategory } from "$lib/common/types";
import type { DonationFormValues } from "./types";

export const DONATE_INITIAL_VALUES: DonationFormValues = {
  totalAmount: 0,
  categories: [
    {
      categoryId: AllocationCategory.DesignAndDevelopment,
      percent: 25,
    },
    {
      categoryId: AllocationCategory.LunchAndSnacks,
      percent: 25,
    },
    {
      categoryId: AllocationCategory.SchoolSupplies,
      percent: 25,
    },
    {
      categoryId: AllocationCategory.TeacherSupport,
      percent: 25,
    },
  ],
};

export const MAP_ALLOCATION_CATEGORY: Record<
  string,
  { label: string; color: string }
> = {
  [AllocationCategory.DesignAndDevelopment]: {
    label: "Design & Development",
    color: "var(--success-color)",
  },
  [AllocationCategory.LunchAndSnacks]: {
    label: "Lunch & Snacks",
    color: "var(--error-color)",
  },
  [AllocationCategory.SchoolSupplies]: {
    label: "School Supplies",
    color: "var(--warning-color)",
  },
  [AllocationCategory.TeacherSupport]: {
    label: "Teacher Support",
    color: "var(--info-color)",
  },
};
