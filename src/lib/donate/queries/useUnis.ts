import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetSchoolsPayload,
  GetSchoolsResponse,
} from "../../../declarations/backend/backend.did";
import { errorModal } from "$lib/common/stores/errorModal";

export const useUnis = (payload: GetSchoolsPayload) => {
  const queryResult = useQuery<GetSchoolsResponse>(
    ["unis", payload],
    () => {
      return backend.getSchools(payload);
    },
    {
      onError: (error) => {
        errorModal.set({ isOpen: true, message: error as string });
      },
    }
  );

  return queryResult;
};
