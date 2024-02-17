import { writable } from "svelte/store";
import { v4 as uuidv4 } from "uuid";
import type { Snackbar } from "../types";

const DEFAULT_TIMEOUT = 10000;

interface AddMessagePayload {
  message: string;
  type?: Snackbar["type"];
  timeout?: number;
}

function createSnackbarStore() {
  const { subscribe, update } = writable<Array<Snackbar>>([]);

  return {
    subscribe,
    addMessage: ({
      message,
      type = "error",
      timeout = DEFAULT_TIMEOUT,
    }: AddMessagePayload) => {
      const id = uuidv4();

      update((messages) => [{ id, message, type, timeout }, ...messages]);

      setTimeout(() => {
        update((messages) => messages.filter((m) => m.id !== id));
      }, timeout);
    },
  };
}
export default createSnackbarStore();
