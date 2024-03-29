import { backendStore, snackbarStore } from "$lib/common/stores";
import { useQuery } from "@sveltestack/svelte-query";
import { get } from "svelte/store";
import type { GetStudentsPayload } from "../../../declarations/backend/backend.did";
import { serializeWithBigInt } from "$lib/common/utils";

export default function useSchools({
  schoolId,
  ...payload
}: GetStudentsPayload & { schoolId: string }) {
  const schoolsQuery = useQuery(
    [schoolId, "students", serializeWithBigInt(payload)],
    async () => {
      return get(backendStore).getStudents(schoolId, payload);
    },
    {
      onError: (error) => {
        snackbarStore.addMessage({
          type: "error",
          message: "Failed to fetch students",
        });

        console.error(error);
      },
    }
  );

  return schoolsQuery;
}
