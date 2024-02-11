<script>
  import Button from "$lib/common/components/Button.svelte";

  import { QueryClient, QueryClientProvider } from "@sveltestack/svelte-query";

  const queryClient = new QueryClient();
</script>

<QueryClientProvider client={queryClient}>
  <main>
    <slot />
  </main>
</QueryClientProvider>

<style lang="scss">
  @import "$lib/common/styles/theme.scss";
  @import "$lib/common/styles/typography.scss";
  main {
    padding: 0;
  }
</style>
