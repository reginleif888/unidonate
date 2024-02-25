import { derived } from "svelte/store";
import backendStore from "./backend-store";
import authStore from "./auth-client-store";

const isAdminStore = derived(
  [authStore, backendStore],
  async ([$authStore, $backendStore]) => {
    if ($backendStore && $authStore) {
      return await $backendStore.isAdmin(
        $authStore.getIdentity().getPrincipal()
      );
    }

    return false;
  }
);

export default isAdminStore;
