<script lang="ts" generics="T extends UniqueIdentifier, TRow extends IRow<T>">
  import { type UniqueIdentifier } from "$lib/common/types";
  import { type Column, type Row as IRow } from "../table.types";

  import Row from "./row.svelte";

  export let row: TRow;
  export let columns: Array<Column<TRow>>;
</script>

<div class="mobile-table__card-root">
  {#each columns as column}
    <Row {column} {row} value={row[column.key]} />
  {/each}
</div>

<style lang="scss">
  .mobile-table__card-root {
    display: flex;
    flex-direction: column;
    border: 1px solid var(--uni-divider-color);
    background-color: var(--uni-bg);
  }

  :global(.mobile-table__card-root .mobile-table__row-root:not(:last-child)) {
    border-bottom: 1px solid var(--uni-divider-color);
  }
</style>
