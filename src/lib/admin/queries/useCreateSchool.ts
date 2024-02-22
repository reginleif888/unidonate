import { backendStore, snackbarStore } from "$lib/common/stores";
import { useMutation, useQueryClient } from "@sveltestack/svelte-query";
import { get } from "svelte/store";
import type { AddSchoolPayload } from "../../../declarations/backend/backend.did";

export default function useCreateSchool() {
  const queryClient = useQueryClient();

  const createSchool = useMutation(
    (payload: AddSchoolPayload) => {
      return get(backendStore).addSchool(payload);
    },
    {
      onSuccess: () => {
        queryClient.refetchQueries("schools");

        snackbarStore.addMessage({
          type: "success",
          message: "School created successfully",
        });
      },
      onError: () => {
        snackbarStore.addMessage({
          type: "error",
          message: "Failed to create school",
        });
      },
    }
  );

  return createSchool;
}