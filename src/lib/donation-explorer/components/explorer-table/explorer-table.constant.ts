import type { IColumn } from "$lib/common/components";
import type { SelectItem } from "$lib/common/types";
import { MAP_ALLOCATION_CATEGORY } from "$lib/donate/constant";
import { OrderByOption, type FormDonation } from "$lib/donation-explorer/types";
import { ActionCell } from "./components";

export const orderByOptions: Array<SelectItem> = [
  {
    label: "Newest first",
    value: OrderByOption.VerifiedAtDesc,
  },
  {
    label: "Oldest first",
    value: OrderByOption.VerifiedAtAsc,
  },
  {
    label: "Highest amount first",
    value: OrderByOption.AmountDesc,
  },
  {
    label: "Lowest amount first",
    value: OrderByOption.AmountAsc,
  },
];

export const columns: Array<IColumn<FormDonation>> = [
  {
    key: "id",
    label: "Donation transaction Id",
    rowTooltipWithCopyOption: true,
  },
  {
    key: "transactionId",
    label: "Bitcoin transaction Id",
    rowTooltipWithCopyOption: true,
  },
  {
    key: "amount",
    label: "Amount",
    format: (value): string => `${value} BTC`,
  },

  {
    key: "allocations",
    label: "Allocations",
    format: (value: FormDonation["allocations"]): string => {
      const allocations = value;

      return Object.entries(allocations)
        .map(
          ([key, value]) => `${MAP_ALLOCATION_CATEGORY[key].emoji}: ${value}%`
        )
        .join(", ");
    },
  },

  {
    key: "verifiedAt",
    label: "Verified at",
  },

  {
    key: "actions",
    noResize: true,
    minWidth: 100,
    width: 100,
    maxWidth: 100,
    label: "",
    Cell: ActionCell,
  },
];
