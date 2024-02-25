import type { IColumn } from "$lib/common/components";
import type { SelectItem } from "$lib/common/types";
import { MAP_ALLOCATION_CATEGORY } from "$lib/donate/constant";
import { AllocationCategory } from "$lib/donate/types";
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

// id: string;
// transactionId: string;
// paymentAddress: string;
// allocations: Record<AllocationCategory, string>;
// amount: string;
// verifiedAt: string;

export const donationMockData: Array<FormDonation> = [
  {
    id: "1",
    transactionId: "1fasdafsdadfsafdasfadfafadfadfsdsf",
    paymentAddress: "asdfasdfasdfasdfasdfadsffadsasdfasdffasd1",
    amount: "10",
    verifiedAt: "01/01/2021",
    allocations: {
      [AllocationCategory.DesignAndDevelopment]: "1",
      [AllocationCategory.LunchAndSnacks]: "1",
      [AllocationCategory.SchoolSupplies]: "1",
      [AllocationCategory.TeacherSupport]: "1",
    },
  },
  {
    id: "2",
    transactionId: "1asdfaadsfdafsadfsadfadfdafsdfa",
    paymentAddress: "1sadfsdfsadafsafdsadfsfasdfasdfasdfasdf",
    amount: "10",
    verifiedAt: "01/01/2021",
    allocations: {
      [AllocationCategory.DesignAndDevelopment]: "1",
      [AllocationCategory.LunchAndSnacks]: "1",
      [AllocationCategory.SchoolSupplies]: "1",
      [AllocationCategory.TeacherSupport]: "1",
    },
  },
  ...Array.from({ length: 10 }, (_, i) => ({
    id: `${i + 3}`,
    transactionId: `1fasdafsdadfsafdasfadfafadfadfsdsf${i}`,
    paymentAddress: `asdfasdfasdfasdfasdfadsffadsasdfasdffasd${i}`,
    amount: "10",
    verifiedAt: "01/01/2021",
    allocations: {
      [AllocationCategory.DesignAndDevelopment]: "1",
      [AllocationCategory.LunchAndSnacks]: "1",
      [AllocationCategory.SchoolSupplies]: "1",
      [AllocationCategory.TeacherSupport]: "1",
    },
  })),
];
