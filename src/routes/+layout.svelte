<script>
  import BurgerMenu from "$lib/common/components/BurgerMenu.svelte";
  import MobileHeader from "$lib/common/components/MobileHeader.svelte";
  import { screenWidth } from "$lib/common/stores/screen";
  import { Screen } from "$lib/common/constant";
  import { showHeader } from "$lib/common/stores/showHeader";
  import { burgerOpened } from "$lib/common/stores/burgerOpened";
  import ErrorModal from "$lib/common/components/ErrorModal.svelte";
  import ThemeSwitch from "$lib/common/components/ThemeSwitch.svelte";
  import { QueryClient, QueryClientProvider } from "@sveltestack/svelte-query";

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

  const queryClient = new QueryClient();
</script>

<QueryClientProvider>
  <MobileHeader />
  <main class="root">
    <div class="theme-switch-mobile">
      <ThemeSwitch />
    </div>
    <slot />

    {#if $screenWidth <= Screen.md}
      <BurgerMenu />
    {/if}

    <ErrorModal />
  </main>
</QueryClientProvider>

<style>
  .root {
    padding: 0 8px;
    padding-top: 116px;
  }

  .theme-switch-mobile {
    margin-bottom: 8px;
  }
</style>
