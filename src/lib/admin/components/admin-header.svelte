<script lang="ts">
  import { goto } from "$app/navigation";
  import { page } from "$app/stores";
  import { BurgerButton, Only, Tabs } from "$lib/common/components";
  import { MODES, SCREEN } from "$lib/common/constant";
  import { AdminRoute } from "$lib/common/routes";
  import {
    burgerMenuStore,
    screenWidthStore,
    themeStore,
  } from "$lib/common/stores";
  import type { TabRoute } from "$lib/common/types";
  import { resolveAppRoute } from "$lib/common/utils";
  import { onMount, onDestroy } from "svelte";

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

    if (selectedRoute === AdminRoute.Students) {
      selectedRoute = AdminRoute.Schools;
    }
  }
</script>

<header class:hidden-header={!showHeader}>
  <div class="logo-wrapper h6"><a href={AdminRoute.Connect}>UniDonate Admin</a></div>

  {#if !hiddenNavigation}
    <div class="inner">
      <Only from="tablet">
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

      <Only to="tablet">
        <BurgerButton
          onlyBurger
          on:click={openBurger}
          open={$burgerMenuStore}
        />
      </Only>
    </div>
  {/if}

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
    height: 62px;

    @include respond-to("tablet") {
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
    width: 200px;
    position: absolute;
    left: 0px;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    align-items: center;
    font-size: 18px;
    padding-left: 16px;
    cursor: pointer;

    & a {
      color: var(--uni-on-primary);
      text-decoration: none;
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
