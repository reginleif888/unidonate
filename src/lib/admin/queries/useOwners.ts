import { backendStore, snackbarStore } from "$lib/common/stores";
import { useQuery } from "@sveltestack/svelte-query";
import { get } from "svelte/store";

export default function useOwners() {
  const ownersQuery = useQuery(
    "owners",
    async () => {
      return get(backendStore).getOwners();
    },
    {
      onError: (error) => {
        snackbarStore.addMessage({
          type: "error",
          message: "Failed to fetch owners",
        });

        console.error(error);
      },
    }
  );

  return ownersQuery;
}
