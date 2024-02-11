import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetDonationsPayload,
  GetDonationsResponse,
} from "../../../declarations/backend/backend.did";
import { errorModal } from "$lib/common/stores";

export const useDonations = (payload: GetDonationsPayload) => {
  const queryResult = useQuery<GetDonationsResponse>(
    ["donations", payload],
    () => {
      return backend.getDonations(payload);
    },
    {
      onError: (error) => {
        errorModal.set({ isOpen: true, message: error as string });
      },
    }
  );

  return queryResult;
};
