import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetSchoolsPayload,
  GetSchoolsResponse,
} from "../../../declarations/backend/backend.did";

interface Payload extends GetSchoolsPayload {
  enabled: boolean;
}

export default function useSchools({ enabled = true, ...payload }: Payload) {
  const queryResult = useQuery<GetSchoolsResponse>(
    ["unis", payload],
    () => {
      return backend.getSchools(payload);
    },
    {
      enabled,
    }
  );

  return queryResult;
}
