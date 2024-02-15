<script lang="ts">
  import UniCard from "./uni-card.svelte";

  import { unis } from "$lib/donate/mocks";
  import type { FormUni } from "$lib/donate/types";
  import type { UniqueIdentifier } from "$lib/common/types";
  import SkeletonCard from "./skeleton-card.svelte";
  import { fade } from "svelte/transition";

  export let selected: UniqueIdentifier | null = null;
  export let perPage: number = 10;
  export let loading = false;

  function onSelect(uni: FormUni) {
    selected = uni.id;
  }
</script>

<div>
  {#if !loading}
    <div class="grid" in:fade={{ duration: 150 }}>
      {#each unis as uni ("uni" + uni.id)}
        <div>
          <UniCard {uni} {onSelect} selected={selected === uni.id} />
        </div>
      {/each}
    </div>
  {/if}

  {#if loading}
    <div class="grid">
      {#each Array(perPage).keys() as i ("skeleton-uni" + i)}
        <div>
          <SkeletonCard />
        </div>
      {/each}
    </div>
  {/if}
</div>

<style>
  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 16px;
  }
</style>
