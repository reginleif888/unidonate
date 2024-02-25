import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetStudentsPayload,
  GetStudentsResponse,
} from "../../../declarations/backend/backend.did";
import { serializeWithBigInt } from "$lib/common/utils";

interface Payload extends GetStudentsPayload {
  enabled: boolean;
  schoolId: string;
}

export default function useStudents({
  enabled = true,
  schoolId,
  ...payload
}: Payload) {
  const queryResult = useQuery<GetStudentsResponse>(
    ["students", serializeWithBigInt(payload)],
    () => {
      return backend.getStudents(schoolId, payload);
    },
    {
      enabled: Boolean(schoolId) && enabled,
    }
  );

  return queryResult;
}
