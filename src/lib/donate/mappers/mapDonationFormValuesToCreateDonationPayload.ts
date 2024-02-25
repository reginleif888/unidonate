import { toBigInt } from "$lib/common/utils";
import type {
  AllocationCategory,
  CreateDonationPayload,
} from "../../../declarations/backend/backend.did";
import type { DonationFormValues } from "../types";

interface Params extends DonationFormValues {
  schoolId: string;
  studentId?: string;
}

export default function mapDonationFormValuesToCreateDonationPayload({
  satoshi,
  schoolId,
  studentId,
  categories,
}: Params): CreateDonationPayload {
  return {
    amount: toBigInt(Number(satoshi)),
    schoolId: schoolId,
    studentId: studentId ? [studentId] : [],
    allocations: Object.entries(categories).map(([categoryId, percent]) => ({
      [categoryId]: percent,
    })) as unknown as Array<AllocationCategory>,
  };
}
