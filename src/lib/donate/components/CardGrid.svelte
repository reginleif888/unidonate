<script lang="ts">
  import type { GridItem } from "$lib/donate/types";
  import Card from "./Card.svelte";

  export let value: string | null = null;
  export let items: Array<GridItem> = [];
  export let onSelect: (id: string) => void = () => null;

  const handleSelect = (item: GridItem) => {
    if (item.id === value) {
      value = "";
      onSelect("");
      return;
    }

    value = item.id;

    onSelect(item.id);
  };
</script>

<div class="root">
  {#each items as item (item.id)}
    <Card {item} selected={item.id === value} onClick={handleSelect} />
  {/each}
</div>

<style>
  .root {
    display: grid;
    gap: 20px;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  }
</style>
