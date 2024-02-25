import { backendStore, snackbarStore } from "$lib/common/stores";
import { useMutation, useQueryClient } from "@sveltestack/svelte-query";
import { get } from "svelte/store";
import type { AddStudentPayload } from "../../../declarations/backend/backend.did";

interface UseCreateSchoolParams {
  withoutSuccessSnackbar?: boolean;
  schoolId: string;
}

export default function useCreateStudent({
  withoutSuccessSnackbar,
  schoolId,
}: UseCreateSchoolParams) {
  const queryClient = useQueryClient();

  const createStudent = useMutation(
    (payload: AddStudentPayload) => {
      return get(backendStore).addStudent(schoolId, payload);
    },
    {
      onSuccess: () => {
        queryClient.refetchQueries([schoolId, "students"]);

        if (!withoutSuccessSnackbar) {
          snackbarStore.addMessage({
            type: "success",
            message: "Student created successfully",
          });
        }
      },
      onError: () => {
        snackbarStore.addMessage({
          type: "error",
          message: "Failed to create student",
        });
      },
    }
  );

  return createStudent;
}
