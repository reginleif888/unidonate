import { useMutation } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type { CreateDonationPayload } from "../../../declarations/backend/backend.did";

export const useCreateDonation = () => {
  const createDonation = useMutation((payload: CreateDonationPayload) => {
    return backend.createDonation(payload);
  });

  return createDonation;
};
