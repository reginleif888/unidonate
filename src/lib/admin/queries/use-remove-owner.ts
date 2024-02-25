import { backendStore, snackbarStore } from "$lib/common/stores";
import type { Principal } from "@dfinity/principal";
import { useQueryClient, useMutation } from "@sveltestack/svelte-query";
import { get } from "svelte/store";

export default function useRemoveOwner() {
  const queryClient = useQueryClient();

  const removeOwner = useMutation(
    (payload: Principal) => get(backendStore).removeOwner(payload),
    {
      onSuccess: () => {
        queryClient.refetchQueries("owners");

        snackbarStore.addMessage({
          type: "success",
          message: "Owner deleted successfully",
        });
      },
      onError: () => {
        snackbarStore.addMessage({
          type: "error",
          message: "Failed to delete owner",
        });
      },
    }
  );

  return removeOwner;
}
