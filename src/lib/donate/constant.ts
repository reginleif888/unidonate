import { AllocationCategory } from "./types";
import type { DonationFormValues, SelectItem } from "./types";

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
    label: "Design & Development 👨‍💻",
    color: "#008080",
  },
  [AllocationCategory.LunchAndSnacks]: {
    label: "Lunch & Snacks 🥪",
    color: "#EB4D55",
  },
  [AllocationCategory.SchoolSupplies]: {
    label: "School Supplies 🎒",
    color: "#FFC107",
  },
  [AllocationCategory.TeacherSupport]: {
    label: "Teacher Support 🧑‍🏫",
    color: "#0F52BA",
  },
};

export const PAGE_SIZES = [5, 10, 20, 50];

export const DEFAULT_PAGE_SIZE = 5;

export const PAGE_SIZES_SELECT_ITEMS: Array<SelectItem> = PAGE_SIZES.map(
  (size) => ({
    value: size.toString(),
    label: size.toString(),
  })
);
