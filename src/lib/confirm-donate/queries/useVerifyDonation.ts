import { useMutation } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import { errorModal } from "$lib/common/stores";
import type { VerifyDonationPayload } from "../../../declarations/backend/backend.did";

type UseVerifyDonationParams = {
  onVerify?: () => void;
};

export const useVerifyDonation = ({ onVerify }: UseVerifyDonationParams) => {
  const createDonation = useMutation(
    (payload: VerifyDonationPayload) => {
      return backend.verifyDonation(payload).then((data) => {
        return (data as any).ok;
      });
    },
    {
      onError: (error) => {
        errorModal.set({ isOpen: true, message: error as string });
      },
      onSuccess: (data) => {
        // @ts-ignore
        if (data.err) {
          // @ts-ignore
          errorModal.set({ isOpen: true, message: data.err as string });
        } else {
          onVerify?.();
        }
      },
    }
  );

  return createDonation;
};
