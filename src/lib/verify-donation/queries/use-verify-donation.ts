import { useMutation } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type { VerifyDonationPayload } from "../../../declarations/backend/backend.did";

export default function useVerifyDonation() {
  const createDonation = useMutation((payload: VerifyDonationPayload) => {
    return backend.verifyDonation(payload);
  });

  return createDonation;
}
