import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetDonationsPayload,
  GetDonationsResponse,
} from "../../../declarations/backend/backend.did";

export const useDonations = (payload: GetDonationsPayload) => {
  const queryResult = useQuery<GetDonationsResponse>(
    ["donations", payload],
    () => {
      return backend.getDonations(payload);
    }
  );

  return queryResult;
};
