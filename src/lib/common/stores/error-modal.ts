import { writable } from "svelte/store";

type ErrorModal = {
  isOpen: boolean;
  message: string;
};

const errorModal = writable<ErrorModal>({
  isOpen: false,
  message: "",
});

export default errorModal;
