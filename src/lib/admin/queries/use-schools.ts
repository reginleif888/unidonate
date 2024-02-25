import { backendStore, snackbarStore } from "$lib/common/stores";
import { useQuery } from "@sveltestack/svelte-query";
import { get } from "svelte/store";
import type { GetSchoolsPayload } from "../../../declarations/backend/backend.did";
import { serializeWithBigInt } from "$lib/common/utils";

export default function useSchools(payload: GetSchoolsPayload) {
  const schoolsQuery = useQuery(
    ["schools", serializeWithBigInt(payload)],
    async () => {
      return get(backendStore).getSchools(payload);
    },
    {
      onError: (error) => {
        snackbarStore.addMessage({
          type: "error",
          message: "Failed to fetch schools",
        });

        console.error(error);
      },
    }
  );

  return schoolsQuery;
}
