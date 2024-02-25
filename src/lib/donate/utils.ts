import type { School, Student } from "../../declarations/backend/backend.did";
import { MAP_ALLOCATION_CATEGORY } from "./constant";
import type {
  AllocationCategory,
  DonationError,
  DonationFormValues,
  GridItem,
} from "./types";

export function validateDonation(
  values: DonationFormValues
): DonationError | null {
  let errors = null;

  if (!values.satoshi || values.satoshi <= 0) {
    return {
      satoshi: true,
      message: "Please enter a valid amount.",
      client: true,
    };
  }

  const categoriesSum = Object.values(values.categories).reduce(
    (acc, curr) => acc + curr,
    0
  );

  if (categoriesSum < 100) {
    return {
      satoshi: false,
      message: "Please allocate 100% of the donation.",
      client: true,
    };
  }

  if (categoriesSum > 100) {
    const biggestCategory = Object.keys(values.categories).reduce((a, b) =>
      values.categories[a] > values.categories[b] ? a : b
    ) as AllocationCategory;

    return {
      satoshi: false,
      message:
        "Percentage sum of categories is greater than 100%. The biggest category is " +
        MAP_ALLOCATION_CATEGORY[biggestCategory].label +
        ". Please reduce the percentage of some categories.",
      biggestCategory: Object.keys(values.categories).reduce((a, b) =>
        values.categories[a] > values.categories[b] ? a : b
      ) as AllocationCategory,
      client: true,
    };
  }

  return errors;
}
