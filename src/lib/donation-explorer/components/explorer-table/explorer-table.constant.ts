import type { IColumn } from "$lib/common/components";
import { MAP_ALLOCATION_CATEGORY } from "$lib/donate/constant";
import type { FormDonation } from "$lib/donation-explorer/types";

export const orderByOptions = [
  {
    label: "By latest",
    value: "byLatest",
  },
  {
    label: "By newest",
    value: "byNewest",
  },
];

export const columns: Array<IColumn<FormDonation>> = [
  {
    key: "id",
    label: "Donation transaction Id",
  },
  {
    key: "transactionId",
    label: "Bitcoin transaction Id",
  },
  {
    key: "paymentAddress",
    label: "Payment address",
  },
  {
    key: "amount",
    label: "Amount",
    format: (value): string => `${value} BTC`,
  },
  {
    key: "allocations",
    label: "Payment address",
    format: (value: FormDonation["allocations"]): string => {
      const allocations = value;

      return Object.entries(allocations)
        .map(
          ([key, value]) => `${MAP_ALLOCATION_CATEGORY[key].label}: ${value}%`
        )
        .join(", ");
    },
  },
];
