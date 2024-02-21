import { writable } from "svelte/store";
import { SCREEN } from "../constant";

function createScreenWidthStore() {
  const { subscribe, set } = writable(window.innerWidth);

  function updateWidth() {
    set(window.innerWidth);
  }

  window?.addEventListener("resize", updateWidth);

  return {
    subscribe,
  };
}

export const screenWidth =
  typeof window === "undefined"
    ? writable<number>(SCREEN.largeDesktop)
    : createScreenWidthStore();

export default screenWidth;
