<script lang="ts">
  import {
    authClientStore,
    backendStore,
    isAdminStore,
  } from "$lib/common/stores";
  import { AdminRoute } from "$lib/common/routes";
  import { Redirect, Spinner, Page } from "$lib/common/components";
  import { page } from "$app/stores";
  import { onMount } from "svelte";
  import { AuthClient } from "@dfinity/auth-client";

  onMount(async () => {
    if (!$authClientStore) {
      $authClientStore = await AuthClient.create();
    }
  });
</script>

{#if $authClientStore && $backendStore}
  {#await $isAdminStore}
    <div class="spinner-page-wrapper">
      <img src="/images/space-guy.webp" alt="space-guy" />
    </div>
  {:then isAdmin}
    {#if isAdmin || $page.route.id === AdminRoute.Connect}
      <slot />
    {:else}
      <Redirect to={AdminRoute.Connect} />
    {/if}
  {/await}
{/if}

<style lang="scss">
  .spinner-page-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    width: 100%;
    background-color: var(--uni-primary);
  }
</style>
