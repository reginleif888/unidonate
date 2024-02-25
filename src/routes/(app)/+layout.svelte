<script lang="ts">
  import { APP_TABS_ROUTES } from "$lib/common/routes";
  import { Header, BurgerMenu } from "$lib/common/components";
  import { QueryClient, QueryClientProvider } from "@sveltestack/svelte-query";
  import { GithubLogo } from "phosphor-svelte";
  import { onMount } from "svelte";
  import { themeStore } from "$lib/common/stores";

  const queryClient = new QueryClient();

  onMount(() => {
    const themeFromStorage = localStorage.getItem("uni-theme");

    if (themeFromStorage && ["light", "dark"].includes(themeFromStorage)) {
      themeStore.updateTheme(themeFromStorage);
    } else {
      themeStore.updateTheme("light");
    }
  });
</script>

<svelte:head>
  <title>UniDonate</title>
</svelte:head>

<QueryClientProvider client={queryClient}>
  <main>
    <Header tabRoutes={APP_TABS_ROUTES} />
    <BurgerMenu tabRoutes={APP_TABS_ROUTES} />
    <div class="content">
      <slot />
    </div>

    <footer>
      <ul>
        <li>
          <a
            class="github"
            href="https://github.com/reginleif888/unidonate"
            target="_blank"
            rel="noopener noreferrer"><GithubLogo size={20} /></a
          >
        </li>
      </ul>
      <span class="caption">Powered by Internet Computer</span>
    </footer>
  </main>
</QueryClientProvider>

<style lang="scss">
  @import "$lib/common/styles/theme.scss";
  @import "$lib/common/styles/media.scss";
  @import "$lib/common/styles/typography.scss";

  main {
    display: flex;
    flex-direction: column;
    background-color: var(--uni-bg);
    color: var(--uni-on-bg);
    min-height: 100%;
  }

  .content {
    flex-grow: 1;
    display: flex;
    flex-direction: column;
  }

  .github {
    color: var(--uni-primary);
  }

  footer {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 16px;
    gap: 4px;
    border-top: 1px solid var(--uni-divider-color);
    background-color: var(--uni-bg-400);

    @include respond-to("desktop") {
      padding: 24px;
    }
  }
</style>
