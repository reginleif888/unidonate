<script lang="ts" generics="T extends UniqueIdentifier, TRow extends IRow<T>">
  import { type UniqueIdentifier } from "$lib/common/types";
  import type { Column, Row as IRow } from "../table.types";
  import Card from "./card.svelte";

  export let rows: Array<TRow>;
  export let columns: Array<Column<TRow>>;
</script>

<div class="table-root">
  {#each rows as row}
    <Card {row} {columns} />
  {/each}
</div>

<style lang="scss">
  .table-root {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }
</style>
