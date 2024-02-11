import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import { errorModal } from "$lib/common/stores";
import type { Student } from "../../../declarations/backend/backend.did";

export const useStudents = (search: string) => {
  const queryResult = useQuery(
    ["students", search],
    () => {
      return backend
        .getStudents(search)
        .then((data) => (data as any).ok as Array<Student>);
    },
    {
      onError: (error) => {
        errorModal.set({ isOpen: true, message: error as string });
      },
      onSuccess: (data) => {
        // @ts-ignore
        if (data.err) {
          // @ts-ignore
          errorModal.set({ isOpen: true, message: data.err as string });
        }
      },
    }
  );

  return queryResult;
};
