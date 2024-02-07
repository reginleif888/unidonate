import { useMutation } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import { errorModal } from "$lib/common/stores/errorModal";
import type {
  CreateDonationPayload,
  CreateDonationResponse,
} from "../../../declarations/backend/backend.did";

export const useCreateDonation = () => {
  const createDonation = useMutation(
    (payload: CreateDonationPayload) => {
      return backend.createDonation(payload).then((data) => {
        return (data as any).ok as CreateDonationResponse;
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
        }
      },
    }
  );

  return createDonation;
};
