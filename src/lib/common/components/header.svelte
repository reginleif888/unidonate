<script lang="ts">
  import BurgerButton from "./burger-button.svelte";
  import {
    burgerMenuStore,
    screenWidthStore,
    themeStore,
  } from "$lib/common/stores";
  import LogoFull from "./logo-full.svelte";
  import Tabs from "./tabs.svelte";
  import { ROUTES } from "../routes";
  import Only from "./only.svelte";
  import { MODES, SCREEN } from "../constant";
  import { page } from "$app/stores";
  import { goto } from "$app/navigation";
  import { onMount, onDestroy } from "svelte";

  let lastScrollY = 0;
  let showHeader = true;

  function handleScroll() {
    const scrollY = typeof window !== "undefined" ? window?.scrollY : 0;

    if (scrollY < lastScrollY || scrollY <= 80) {
      showHeader = true;
    } else {
      showHeader = false;
    }

    lastScrollY = scrollY;
  }

  onMount(() => {
    if (typeof window !== "undefined") {
      window?.addEventListener("scroll", handleScroll);
    }
  });

  onDestroy(() => {
    if (typeof window !== "undefined") {
      window?.removeEventListener("scroll", handleScroll);
    }
  });

  const openBurger = () => {
    burgerMenuStore.set(true);
  };
</script>

<header class:hidden-header={!showHeader}>
  <div class="logo-wrapper">
    <LogoFull />
  </div>
  <div class="inner">
    <Only from="tablet">
      <div class="tabs-wrapper">
        <Tabs
          options={ROUTES.map(({ route, label, Icon }) => ({
            value: route,
            label,
            Icon: $screenWidthStore > SCREEN.desktop ? Icon : undefined,
          }))}
          fullWidth
          onChange={goto}
          selected={$page.route.id}
        />
      </div>
    </Only>

    <Only to="tablet">
      <BurgerButton onlyBurger on:click={openBurger} open={$burgerMenuStore} />
    </Only>
  </div>
  <Only from="tablet">
    <div class="modes-wrapper">
      <Tabs
        options={MODES}
        selected={$themeStore}
        onChange={themeStore.updateTheme}
        variant="secondary"
      />
    </div>
  </Only>
</header>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  header {
    background-color: var(--uni-primary);
    box-shadow: var(--uni-shadow-paper);
    color: var(--uni-on-primary);
    padding: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: var(--uni-zIndex-app-bar);
    position: sticky;
    top: 0;
    display: flex;
    justify-content: flex-end;

    @include respond-to("tablet") {
      justify-content: center;
    }

    transform: translateY(0%);
    transition: transform var(--uni-transition-default);
  }

  .hidden-header {
    transform: translateY(-100%);
  }

  .logo-wrapper {
    height: 50px;
    width: 200px;
    position: absolute;
    left: 0px;
    top: 50%;
    transform: translateY(-50%);
  }

  .tabs-wrapper {
    display: flex;
    gap: 16px;
    max-width: 900px;
    margin: 0 auto;

    min-width: 400px;

    @include respond-to("desktop") {
      min-width: 600px;
    }

    @include respond-to("largeDesktop") {
      min-width: 800px;
    }
  }

  .inner {
    position: relative;
  }

  .modes-wrapper {
    position: absolute;
    right: 0px;
    top: 50%;
    transform: translateY(-50%);

    @include respond-to("tablet") {
      width: 120px;
    }

    @include respond-to("desktop") {
      width: 160px;
    }

    @include respond-to("largeDesktop") {
      width: 200px;
    }
  }
</style>
