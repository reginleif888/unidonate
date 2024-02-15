<script lang="ts">
  import Drawer from "./drawer.svelte";
  import { burgerMenu, theme } from "$lib/common/stores";
  import { X, Check } from "phosphor-svelte";
  import Divider from "./divider.svelte";
  import Tabs from "./tabs.svelte";
  import { page } from "$app/stores";
  import { ROUTES } from "../routes";
  import { MODES } from "../constant";

  function closeBurger() {
    burgerMenu.set(false);
  }
</script>

<Drawer position="left" open={$burgerMenu} onClose={closeBurger}>
  <div class="header">
    <h2 class="h2">Menu</h2>
    <button on:click={closeBurger} class="close-button">
      <X size={30} />
    </button>
  </div>

  <Divider />

  <nav class="menu">
    <ul class="menu__list">
      {#each ROUTES as { route, label, Icon }}
        <li
          class="menu__list-item subtitle1"
          class:selected={$page.route.id === route}
        >
          <Icon size={24} />
          <a href={route} on:click={closeBurger}>{label}</a>
          {#if $page.route.id === route}
            <div class="check-wrapper">
              <Check size={18} weight="bold" />
            </div>
          {/if}
        </li>
      {/each}
      <div class="modes-wrapper">
        <Tabs options={MODES} selected={$theme} onChange={theme.updateTheme} />
      </div>
    </ul>
  </nav>
</Drawer>

<style lang="scss">
  .close-button {
    background-color: transparent;
    border: unset;
    color: var(--uni-on-bg);
  }

  .header {
    display: flex;
    justify-content: space-between;
    padding: 16px;
  }

  .menu {
    display: flex;
    justify-content: space-between;
    padding: 16px;
  }

  .menu__list {
    list-style: none;
    padding: 0;
  }

  .menu__list-item {
    margin-bottom: 20px;
    color: var(--uni-on-bg);
    display: flex;
    align-items: center;
    gap: 8px;
    position: relative;
    width: fit-content;
  }

  .menu__list-item a {
    color: var(--uni-on-bg);
    text-decoration: none;
  }

  .menu__list-item.selected {
    color: var(--uni-primary);
  }

  .menu__list-item.selected a {
    color: var(--uni-primary);
  }

  .modes-wrapper {
    position: absolute;
    bottom: 8px;
    left: 8px;
    width: calc(100% - 16px);
  }

  .check-wrapper {
    position: absolute;
    right: -32px;
  }
</style>
