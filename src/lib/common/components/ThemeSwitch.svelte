<script lang="ts">
  import Button from "./Button.svelte";
  import theme from "$lib/common/stores/theme";
  import { onMount } from "svelte";
  import { Sun, Moon } from "phosphor-svelte";

  const linkId = "theme-style";

  function updateTheme(theme: string) {
    let link = document.getElementById(linkId) as HTMLLinkElement;

    if (!link) {
      link = document.createElement("link");
      link.id = linkId;
      link.rel = "stylesheet";
      document.head.appendChild(link);
    }

    link.href = `${theme}.css`;

    window.localStorage.setItem("theme", theme);
  }

  onMount(() => {
    let link = document.getElementById(linkId) as HTMLLinkElement;

    if (!link) {
      const themeFromStorage = window.localStorage.getItem("theme");

      updateTheme(themeFromStorage ? themeFromStorage : "light");

      theme.update(() => (themeFromStorage ? themeFromStorage : "light"));
    }

    const unsubscribe = theme.subscribe((value) => {
      document.body.classList.remove("light", "dark");
      document.body.classList.add(value);
    });

    return () => {
      unsubscribe();
    };
  });

  function setLightTheme() {
    theme.update(() => "light");

    updateTheme("light");
  }

  function setDarkTheme() {
    theme.update(() => "dark");

    updateTheme("dark");
  }
</script>

<div class="button_switch">
  <Button
    label=""
    className="button_switch__button"
    onClick={setLightTheme}
    contained={$theme === "light"}
  >
    <div slot="start-icon">
      <Sun size={20} />
    </div>
  </Button>
  <Button
    label=""
    className="button_switch__button"
    contained={$theme === "dark"}
    onClick={setDarkTheme}
  >
    <div slot="start-icon">
      <Moon size={20} />
    </div>
  </Button>
</div>

<style>
  .button_switch {
    display: flex;
    width: fit-content;
  }

  :global(.button_switch__button.button_switch__button:not(:first-child)) {
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
  }

  :global(.button_switch__button.button_switch__button:not(:last-child)) {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
  }

  :global(.button_switch__button.button_switch__button:not(:last-child)) {
    border-right: 0;
  }
</style>
