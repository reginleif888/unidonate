import { writable } from "svelte/store";

const theme = writable<string>("light");

function createThemeStore() {
  const { subscribe, set } = theme;

  function updateTheme(theme: string) {
    document.documentElement.classList.remove("light", "dark");
    document.documentElement.classList.add(theme);

    localStorage.setItem("uni-theme", theme);

    set(theme);
  }

  return {
    subscribe,
    updateTheme,
  };
}

export default createThemeStore();
