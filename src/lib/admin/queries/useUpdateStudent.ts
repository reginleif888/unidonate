import { backendStore, snackbarStore } from "$lib/common/stores";
import { useMutation, useQueryClient } from "@sveltestack/svelte-query";
import { get } from "svelte/store";
import type { UpdateStudentPayload } from "../../../declarations/backend/backend.did";

type UseUpdateStudentParams = {
  schoolId: string;
};

export default function useUpdateStudent({ schoolId }: UseUpdateStudentParams) {
  const queryClient = useQueryClient();

  const updatedStudent = useMutation(
    (payload: UpdateStudentPayload) => {
      return get(backendStore).updateStudent(schoolId, payload);
    },
    {
      onSuccess: () => {
        queryClient.refetchQueries([schoolId, "students"]);

        snackbarStore.addMessage({
          type: "success",
          message: "Student updated successfully",
        });
      },
      onError: () => {
        snackbarStore.addMessage({
          type: "error",
          message: "Failed to updated student",
        });
      },
    }
  );

  return updatedStudent;
}
