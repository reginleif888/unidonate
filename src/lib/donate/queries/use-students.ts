import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";
import type { Student } from "../../../declarations/backend/backend.did";

export const useStudents = (search: string) => {
  const queryResult = useQuery(["students", search], () => {
    return backend
      .getStudents(search)
      .then((data) => (data as any).ok as Array<Student>);
  });

  return queryResult;
};
