import { backendStore, snackbarStore } from "$lib/common/stores";
import { useQuery } from "@sveltestack/svelte-query";
import { get } from "svelte/store";
import type { Principal } from "@dfinity/principal";

export default function useOwners(payload: Principal) {
  const ownersQuery = useQuery(
    "owners",
    async () => {
      return get(backendStore).getOwners(payload);
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
