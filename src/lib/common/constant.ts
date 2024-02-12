import { AllocationCategory } from "./types";

export const SCREEN = {
  sm: 576, // Small devices (landscape phones, 576px and up)
  md: 768, // Medium devices (tablets, 768px and up)
  lg: 992, // Large devices (desktops, 992px and up)
  xl: 1200, // Extra large devices (large desktops, 1200px and up)
  xxl: 1400, // Extra extra large devices (larger desktops, 1400px and up)
} as const;

/**
 * @todo
 *
 * move to another module
 */
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
