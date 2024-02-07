<script>
  import BurgerMenu from "$lib/common/components/BurgerMenu.svelte";
  import MobileHeader from "$lib/common/components/MobileHeader.svelte";
  import { screenWidth } from "$lib/common/stores/screen";
  import { Screen } from "$lib/common/constant";
  import { showHeader } from "$lib/common/stores/showHeader";
  import { burgerOpened } from "$lib/common/stores/burgerOpened";

  if (typeof window !== "undefined") {
    let lastScrollY = window.scrollY;
    showHeader.set(true);

    window.addEventListener("scroll", () => {
      const currentScrollY = window.scrollY;

      if (currentScrollY < lastScrollY) {
        showHeader.set(true);
      } else if (currentScrollY > lastScrollY) {
        showHeader.set(false);
        burgerOpened.set(false);
      }

      lastScrollY = currentScrollY;
    });
  }
</script>

<MobileHeader />
<main class="root">
  <slot />

  {#if $screenWidth <= Screen.md}
    <BurgerMenu />
  {/if}
</main>

<style>
  .root {
    padding: 0 8px;
    padding-top: 116px;
  }
</style>
