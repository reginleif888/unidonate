<script>
  import { Header, BurgerMenu } from "$lib/common/components";
  import { QueryClient, QueryClientProvider } from "@sveltestack/svelte-query";
  import { GithubLogo } from "phosphor-svelte";
  import { onMount } from "svelte";
  import { theme } from "$lib/common/stores";

  const queryClient = new QueryClient();

  onMount(() => {
    const themeFromStorage = localStorage.getItem("uni-theme");

    if (themeFromStorage && ["light", "dark"].includes(themeFromStorage)) {
      theme.updateTheme(themeFromStorage);
    } else {
      theme.updateTheme("light");
    }
  });
</script>

<svelte:head>
  <title>Uni Donate</title>
</svelte:head>

<QueryClientProvider client={queryClient}>
  <main>
    <Header />
    <BurgerMenu />
    <div class="content">
      <slot />
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
    background-color: var(--uni-bg-200);
  }
</style>
