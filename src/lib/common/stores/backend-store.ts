import { derived } from "svelte/store";
import {
  backend,
  canisterId,
  createActor,
} from "../../../declarations/backend";
import { authClientStore } from ".";

const backendStore = derived(authClientStore, ($authClient) => {
  if ($authClient) {
    let newBackend = createActor(canisterId, {
      agentOptions: {
        identity: $authClient.getIdentity(),
      },
    });

    return newBackend;
  }

  return backend;
});

export default backendStore;
