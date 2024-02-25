import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetSchoolsPayload,
  GetSchoolsResponse,
} from "../../../declarations/backend/backend.did";
import { serializeWithBigInt } from "$lib/common/utils";

interface Payload extends GetSchoolsPayload {
  enabled: boolean;
}

export default function useSchools({ enabled = true, ...payload }: Payload) {
  const queryResult = useQuery<GetSchoolsResponse>(
    ["schools", serializeWithBigInt(payload)],
    () => {
      return backend.getSchools(payload);
    },
    {
      enabled,
    }
  );

  return queryResult;
}
