<script lang="ts">
  import UniCard from "./UniCard.svelte";

  import { unis } from "$lib/donate/mocks";
  import type { FormUni } from "$lib/donate/types";
  import type { UniqueIdentifier } from "$lib/common/types";
  import SkeletonCard from "./SkeletonCard.svelte";

  export let selected: UniqueIdentifier | null = null;
  export let perPage: number = 10;
  export let loading = false;

  function onSelect(uni: FormUni) {
    selected = uni.id;
  }
</script>

<div class="grid-root">
  {#if !loading}
    {#each unis as uni (uni.id)}
      <div>
        <UniCard {uni} {onSelect} selected={selected === uni.id} />
      </div>
    {/each}
  {/if}

  {#if loading}
    {#each Array(perPage).keys() as i (i)}
      <SkeletonCard />
    {/each}
  {/if}
</div>

<style>
  .grid-root {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 16px;
  }
</style>
