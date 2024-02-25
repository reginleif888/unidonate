<script lang="ts">
  import {
    type FormStudent,
    type FormSchool,
    EntityType,
  } from "$lib/donate/types";
  import type { UniqueIdentifier } from "$lib/common/types";
  import SkeletonCard from "./skeleton-card.svelte";
  import type { SvelteComponent } from "svelte";

  export let selected: UniqueIdentifier | null = null;
  export let perPage: number = 10;
  export let loading = false;
  export let data: Array<FormSchool> | Array<FormStudent> = [];
  export let Entity: typeof SvelteComponent<any>;
  export let entityType: EntityType = EntityType.School;
  export let onSelect: (selected: UniqueIdentifier | null) => void = () => null;

  function onSelectLocal<T extends FormSchool | FormStudent>(data: T) {
    if (selected === data.id) {
      selected = null;

      onSelect(null);

      return;
    }

    selected = data.id;

    onSelect(data.id);
  }
</script>

<div>
  {#if !loading}
    <div class="grid">
      {#each data as item (entityType + item.id)}
        <svelte:component
          this={Entity}
          {item}
          onSelect={onSelectLocal}
          selected={selected === item.id}
        />
      {/each}
    </div>
  {/if}

  {#if loading}
    <div class="grid">
      {#each Array(perPage).keys() as i ("skeleton" + entityType + i)}
        <div>
          <SkeletonCard />
        </div>
      {/each}
    </div>
  {/if}
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 16px;

    @include respond-to("smallTablet") {
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    }
  }
</style>
