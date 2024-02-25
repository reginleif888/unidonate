<script lang="ts">
  import BurgerButton from "./burger-button.svelte";
  import {
    burgerMenuStore,
    screenWidthStore,
    themeStore,
  } from "$lib/common/stores";
  import LogoFull from "./logo-full.svelte";
  import Tabs from "./tabs.svelte";
  import { AppRoute } from "../routes";
  import Only from "./only.svelte";
  import { MODES, SCREEN } from "../constant";
  import { page } from "$app/stores";
  import { goto } from "$app/navigation";
  import { onMount, onDestroy } from "svelte";
  import { resolveAppRoute } from "../utils";
  import type { TabRoute } from "../types";

  export let tabRoutes: Array<TabRoute> = [];
  export let hiddenNavigation: boolean = false;

  let lastScrollY: number = 0;
  let showHeader: boolean = true;

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

  function openBurger() {
    burgerMenuStore.set(true);
  }

  let selectedRoute = resolveAppRoute($page.route.id);

  $: {
    selectedRoute = resolveAppRoute($page.route.id);

    if (selectedRoute === AppRoute.Donation) {
      selectedRoute = AppRoute.Explorer;
    }
  }
</script>

<header class:hidden-header={!showHeader}>
  <a href={AppRoute.Home} class="logo-wrapper">
    <LogoFull />
  </a>

  {#if !hiddenNavigation}
    <div class="inner">
      <Only from="desktop">
        <div class="tabs-wrapper">
          <Tabs
            options={tabRoutes.map(({ route, label, Icon }) => ({
              value: route,
              label,
              Icon: $screenWidthStore > SCREEN.desktop ? Icon : undefined,
            }))}
            fullWidth
            onChange={goto}
            selected={selectedRoute}
          />
        </div>
      </Only>

      <Only to="desktop">
        <BurgerButton
          onlyBurger
          on:click={openBurger}
          open={$burgerMenuStore}
        />
      </Only>
    </div>
  {/if}

  <Only from="desktop">
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
    height: 62px;

    @include respond-to("desktop") {
      justify-content: center;
      height: 80px;
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
    left: -18px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--uni-on-primary);

    @include respond-to("desktop") {
      left: 0px;
    }
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
