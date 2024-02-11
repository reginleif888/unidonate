// import { onDestroy } from "svelte";
import { writable } from "svelte/store";
import { Screen } from "../constant";

function createScreenWidthStore() {
  const { subscribe, set } = writable(window.innerWidth);

  function updateWidth() {
    set(window.innerWidth);
  }

  window?.addEventListener("resize", updateWidth);

  // onDestroy(() => {
  //   window.removeEventListener("resize", updateWidth);
  // });

  return {
    subscribe,
  };
}

export const screenWidth =
  typeof window === "undefined"
    ? writable(Screen.md)
    : createScreenWidthStore();