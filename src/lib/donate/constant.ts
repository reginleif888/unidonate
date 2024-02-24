import type { SelectItem } from "$lib/common/types";
import { AllocationCategory } from "./types";
import type { DonationFormValues, MapAllocationCategoryValue } from "./types";

export const DONATE_INITIAL_VALUES: DonationFormValues = {
  satoshi: 0,
  categories: {
    [AllocationCategory.DesignAndDevelopment]: 25,
    [AllocationCategory.LunchAndSnacks]: 25,
    [AllocationCategory.SchoolSupplies]: 25,
    [AllocationCategory.TeacherSupport]: 25,
  },
};

export const MAP_ALLOCATION_CATEGORY: Record<
  string,
  MapAllocationCategoryValue
> = {
  [AllocationCategory.DesignAndDevelopment]: {
    label: "Design & Development 👨‍💻",

    color: "#0F52BA",
    text: "Design & Development",
    emoji: "👨‍💻",
  },
  [AllocationCategory.LunchAndSnacks]: {
    label: "Lunch & Snacks 🥪",

    color: "#FFC107",
    text: "Lunch & Snacks",
    emoji: "🥪",
  },
  [AllocationCategory.SchoolSupplies]: {
    label: "School Supplies 🎒",
    color: "#EB4D55",
    text: "School Supplies",
    emoji: "🎒",
  },
  [AllocationCategory.TeacherSupport]: {
    label: "Teacher Support 🧑‍🏫",
    color: "#008080",
    text: "Teacher Support",
    emoji: "🧑‍🏫",
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
