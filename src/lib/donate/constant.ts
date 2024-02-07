import type { DonationFormValues } from "./types";

export const DONATE_INITIAL_VALUES: DonationFormValues = {
  totalAmount: 0,
  categories: [
    {
      categoryId: "1",
      amount: 25,
    },
    {
      categoryId: "2",
      amount: 25,
    },
    {
      categoryId: "3",
      amount: 25,
    },
    {
      categoryId: "4",
      amount: 25,
    },
  ],
};
