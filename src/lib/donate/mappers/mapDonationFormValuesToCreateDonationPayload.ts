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
    amount: satoshi as unknown as bigint,
    schoolId: schoolId,
    studentId: studentId ? [studentId] : [],
    allocations: Object.entries(categories).map(([categoryId, percent]) => ({
      [categoryId]: percent,
    })) as unknown as Array<AllocationCategory>,
  };
}
