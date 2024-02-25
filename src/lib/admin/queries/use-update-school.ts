import { useMutation, useQueryClient } from "@sveltestack/svelte-query";
import type { UpdateSchoolPayload } from "../../../declarations/backend/backend.did";
import { backendStore, snackbarStore } from "$lib/common/stores";
import { get } from "svelte/store";

type Payload = {
  id: string;
  payload: UpdateSchoolPayload;
};

export default function useUpdateSchool() {
  const queryClient = useQueryClient();

  const updateSchool = useMutation(
    ({ id, payload }: Payload) => {
      return get(backendStore).updateSchool(id, payload);
    },
    {
      onSuccess: () => {
        queryClient.refetchQueries("schools");

        snackbarStore.addMessage({
          type: "success",
          message: "School updated successfully",
        });
      },
      onError: () => {
        snackbarStore.addMessage({
          type: "error",
          message: "Failed to update school",
        });
      },
    }
  );

  return updateSchool;
}
