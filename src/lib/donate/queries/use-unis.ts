import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetSchoolsPayload,
  GetSchoolsResponse,
} from "../../../declarations/backend/backend.did";

export const useUnis = (payload: GetSchoolsPayload) => {
  const queryResult = useQuery<GetSchoolsResponse>(["unis", payload], () => {
    return backend.getSchools(payload);
  });

  return queryResult;
};
