import { backendStore, snackbarStore } from "$lib/common/stores";
import type { Principal } from "@dfinity/principal";
import { useQueryClient, useMutation } from "@sveltestack/svelte-query";
import { get } from "svelte/store";

function useCreateOwner() {
  const queryClient = useQueryClient();

  const createOwner = useMutation(
    (payload: Principal) => get(backendStore).addOwner(payload),
    {
      onSuccess: () => {
        queryClient.refetchQueries("owners");

        snackbarStore.addMessage({
          type: "success",
          message: "Owner created successfully",
        });
      },
      onError: () => {
        snackbarStore.addMessage({
          type: "error",
          message: "Failed to create owner",
        });
      },
    }
  );

  return createOwner;
}

export default useCreateOwner;
