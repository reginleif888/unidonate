import { AllocationCategory } from "./types";
import type {
  DonationFormValues,
  MapAllocationCategoryValue,
  SelectItem,
} from "./types";

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
  MapAllocationCategoryValue
> = {
  [AllocationCategory.DesignAndDevelopment]: {
    label: "Design & Development 👨‍💻",
    color: "#008080",
    text: "Design & Development",
    emoji: "👨‍💻",
  },
  [AllocationCategory.LunchAndSnacks]: {
    label: "Lunch & Snacks 🥪",
    color: "#EB4D55",
    text: "Lunch & Snacks",
    emoji: "🥪",
  },
  [AllocationCategory.SchoolSupplies]: {
    label: "School Supplies 🎒",
    color: "#FFC107",
    text: "School Supplies",
    emoji: "🎒",
  },
  [AllocationCategory.TeacherSupport]: {
    label: "Teacher Support 🧑‍🏫",
    color: "#0F52BA",
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
