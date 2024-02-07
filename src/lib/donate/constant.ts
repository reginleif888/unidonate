import type { DonationFormValues } from "./types";

export const DONATE_INITIAL_VALUES: DonationFormValues = {
  totalAmount: 0,
  categories: [
    {
      categoryId: "1",
      percent: 25,
    },
    {
      categoryId: "2",
      percent: 25,
    },
    {
      categoryId: "3",
      percent: 25,
    },
    {
      categoryId: "4",
      percent: 25,
    },
  ],
};
