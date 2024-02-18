import type { AllocationCategory } from "$lib/donate/types";

export interface FormDonation {
  id: string;
  transactionId: string;
  paymentAddress: string;
  allocations: Record<AllocationCategory, string>;
  amount: string;
}
