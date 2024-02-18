import { useMutation } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  CreateDonationPayload,
  CreateDonationResponse,
} from "../../../declarations/backend/backend.did";

export const useCreateDonation = () => {
  const createDonation = useMutation((payload: CreateDonationPayload) => {
    return backend.createDonation(payload).then((data) => {
      return (data as any).ok as CreateDonationResponse;
    });
  });

  return createDonation;
};
