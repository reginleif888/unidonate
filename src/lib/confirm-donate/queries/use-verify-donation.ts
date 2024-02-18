import { useMutation } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type { VerifyDonationPayload } from "../../../declarations/backend/backend.did";

type UseVerifyDonationParams = {
  onVerify?: () => void;
};

export const useVerifyDonation = ({ onVerify }: UseVerifyDonationParams) => {
  const createDonation = useMutation((payload: VerifyDonationPayload) => {
    return backend.verifyDonation(payload).then((data) => {
      return (data as any).ok;
    });
  });

  return createDonation;
};
