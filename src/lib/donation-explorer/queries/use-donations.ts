import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetDonationsPayload,
  GetDonationsResponse,
} from "../../../declarations/backend/backend.did";
import { serializeWithBigInt } from "$lib/common/utils";

export default function useDonations(payload: GetDonationsPayload) {
  const donationsQuery = useQuery<GetDonationsResponse>(
    ["donations", serializeWithBigInt(payload)],
    () => {
      return backend.getDonations(payload);
    }
  );

  return donationsQuery;
}
