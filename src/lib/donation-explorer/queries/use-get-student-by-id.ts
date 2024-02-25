import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";

interface Payload {
  studentId: string;
  enabled?: boolean;
}

export default function useGetStudentById({ studentId, enabled }: Payload) {
  const donationQuery = useQuery(
    ["student", studentId],
    () => {
      return backend.getStudentById(studentId);
    },
    {
      enabled,
      retry: false,
    }
  );

  return donationQuery;
}
