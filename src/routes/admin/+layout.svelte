<script lang="ts">
  import { Header, BurgerMenu } from "$lib/common/components";
  import { QueryClient, QueryClientProvider } from "@sveltestack/svelte-query";
  import { GithubLogo } from "phosphor-svelte";
  import { onMount, SvelteComponent } from "svelte";
  import { themeStore } from "$lib/common/stores";

  let StartsBg: typeof SvelteComponent<any>;

  const queryClient = new QueryClient();

  onMount(() => {
    const themeFromStorage = localStorage.getItem("uni-theme");

    if (themeFromStorage && ["light", "dark"].includes(themeFromStorage)) {
      themeStore.updateTheme(themeFromStorage);
    } else {
      themeStore.updateTheme("light");
    }
  });

  onMount(async () => {
    const module = await import("$lib/common/components/starts-bg.svelte");
    StartsBg = module.default;
  });
</script>

<svelte:head>
  <title>Uni Admin</title>
</svelte:head>

<QueryClientProvider client={queryClient}>
  <main>
    <!-- <Header />
    <BurgerMenu /> -->
    <!-- <Snackbar /> -->
    <div class="content">
      <slot />
      <svelte:component this={StartsBg} />
    </div>

    <footer>
      <span class="copy-right-line caption"
        >© uni-donate.com - All rights reserved.</span
      >
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
    position: relative;
    overflow: hidden;
  }

  .copy-right-line {
    margin-bottom: 16px;
  }

  .github {
    color: var(--uni-primary);
  }

  footer {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    padding: 8px;
    padding-top: 16px;
    border-top: 1px solid var(--uni-divider-color);
    background-color: var(--uni-bg-400);
  }
</style>
