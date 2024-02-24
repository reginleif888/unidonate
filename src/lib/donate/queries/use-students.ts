import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type {
  GetStudentsPayload,
  GetStudentsResponse,
} from "../../../declarations/backend/backend.did";

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
    ["unis", payload],
    () => {
      return backend.getStudents(schoolId, payload);
    },
    {
      enabled: Boolean(schoolId) && enabled,
    }
  );

  return queryResult;
}
