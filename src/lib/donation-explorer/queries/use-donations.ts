import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetDonationsPayload,
  GetDonationsResponse,
} from "../../../declarations/backend/backend.did";

export default function useDonations(payload: GetDonationsPayload) {
  const donationsQuery = useQuery<GetDonationsResponse>(
    ["donations", payload],
    () => {
      return backend.getDonations(payload);
    }
  );

  return donationsQuery;
}
