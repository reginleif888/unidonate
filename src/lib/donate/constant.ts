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
