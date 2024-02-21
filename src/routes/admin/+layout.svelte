<script lang="ts">
  import { onMount } from "svelte";
  import { authClientStore } from "$lib/common/stores";
  import { AuthClient } from "@dfinity/auth-client";
  import { AdminRoute } from "$lib/common/routes";
  import { Redirect } from "$lib/common/components";
  import { page } from "$app/stores";

  onMount(async () => {
    if (!$authClientStore) {
      $authClientStore = await AuthClient.create();
    }
  });
</script>

{#if $authClientStore}
  {#await $authClientStore.isAuthenticated() then isAuthenticated}
    {#if isAuthenticated || $page.route.id === AdminRoute.Connect}
      <slot />
    {:else}
      <Redirect to={AdminRoute.Connect} />
    {/if}
  {/await}
{/if}
