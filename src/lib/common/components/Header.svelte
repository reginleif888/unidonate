<script>
  import BurgerButton from "./BurgerButton.svelte";
  import { burgerMenu } from "$lib/common/stores";

  const openBurger = () => {
    burgerMenu.set(true);
  };
</script>

<header>
  Uni Donate<BurgerButton onlyBurger onClick={openBurger} open={$burgerMenu} />
</header>

<style>
  header {
    background-color: var(--uni-primary);
    color: var(--uni-on-primary);
    padding: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: var(--uni-zIndex-app-bar);
    position: sticky;
    top: 0;
  }
</style>
