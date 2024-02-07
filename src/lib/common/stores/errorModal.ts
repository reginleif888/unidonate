import { writable } from "svelte/store";

type ErrorModal = {
  isOpen: boolean;
  message: string;
};

export const errorModal = writable<ErrorModal>({
  isOpen: false,
  message: "",
});
