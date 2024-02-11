<script>
  import { QueryClient, QueryClientProvider } from "@sveltestack/svelte-query";

  const queryClient = new QueryClient();
</script>

<QueryClientProvider client={queryClient}>
  <main class="root">
    <slot />
  </main>
</QueryClientProvider>

<style>
  .root {
    padding: 0;
  }
</style>
