import { useQuery } from "@sveltestack/svelte-query";
import { backend } from "../../../declarations/backend";

interface Payload {
  schoolId: string;
  enabled?: boolean;
}

export default function useGetSchoolById({ schoolId, enabled }: Payload) {
  const donationQuery = useQuery(
    ["school", schoolId],
    () => {
      return backend.getSchoolById(schoolId);
    },
    {
      enabled,
      retry: false,
    }
  );

  return donationQuery;
}
