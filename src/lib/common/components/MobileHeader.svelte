<script>
  import { showHeader } from "$lib/common/stores/showHeader";
  import BurgerButton from "./BurgerButton.svelte";
  import Logo from "./Logo.svelte";
</script>

<header class="header" class:hidden={!$showHeader}>
  <Logo />
  <BurgerButton />
</header>

<style>
  .header {
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 49;
    height: 100px;
    background-color: var(--secondary-bg);
    border-bottom: 1px solid var(--divider-color);
    color: var(--brand-primary-color);
    transition: transform 0.3s ease-in-out;

    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 8px;
    padding-left: 0;
  }
  .hidden {
    transform: translateY(-200%);
  }
</style>
