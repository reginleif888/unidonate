import { onDestroy } from "svelte";
import { writable } from "svelte/store";
import { Screen } from "../constant";

function getScreenWidthCategory(width: number) {
  if (width < 576) {
    return Screen.xs;
  } else if (width >= 576 && width < 768) {
    return Screen.sm;
  } else if (width >= 768 && width < 992) {
    return Screen.md;
  } else if (width >= 992 && width < 1200) {
    return Screen.lg;
  } else if (width >= 1200 && width < 1400) {
    return Screen.xl;
  } else {
    return Screen.xxl;
  }
}

function createScreenWidthStore() {
  const { subscribe, set } = writable(
    getScreenWidthCategory(window.innerWidth)
  );

  function updateWidth() {
    set(getScreenWidthCategory(window.innerWidth));
  }

  window.addEventListener("resize", updateWidth);

  onDestroy(() => {
    window.removeEventListener("resize", updateWidth);
  });

  return {
    subscribe,
  };
}

export const screenWidth = createScreenWidthStore();
