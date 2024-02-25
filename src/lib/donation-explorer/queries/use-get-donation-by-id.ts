import { useMutation, useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";

interface Payload {
  donationId: string;
}

export function useGetDonationByIdMutation() {
  const donationsMutation = useMutation(({ donationId }: Payload) => {
    return backend.getDonationById(donationId);
  });

  return donationsMutation;
}

export function useGetDonationByIdQuery({ donationId }: Payload) {
  const donationQuery = useQuery(["donation", donationId], () => {
    return backend.getDonationById(donationId);
  });

  return donationQuery;
}
