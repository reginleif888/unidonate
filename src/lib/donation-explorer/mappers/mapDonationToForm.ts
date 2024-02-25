import { satsToBtcString } from "$lib/common/utils";
import { AllocationCategory } from "$lib/donate/types";
import type { Donation } from "../../../declarations/backend/backend.did";
import type { FormDonation } from "../types";

export default function mapDonationToForm(donation: Donation): FormDonation {
  return {
    id: donation.donationId,
    transactionId: donation.transactionId[0] ?? "",
    paymentAddress: donation.paymentAddress,
    amount: satsToBtcString(donation.amount.toString())
      .replace(/(\.\d*?[1-9])0+$/, "$1")
      .replace(/\.0+$/, ""),
    verifiedAt: donation.verifiedAt[0]
      ? new Date(Number(donation.verifiedAt[0]) / 1000000).toLocaleString()
      : "N/A",
    allocations: donation.allocations.reduce(
      (acc, allocation) => ({ ...acc, ...allocation }),
      {}
    ) as Record<AllocationCategory, string>,
  };
}
