<script lang="ts" generics="T extends UniqueIdentifier, TRow extends IRow<T>">
  import { type UniqueIdentifier } from "$lib/common/types";
  import { type Column, type Row as IRow } from "../table.types";
  import Row from "./row.svelte";

  export let row: TRow;
  export let columns: Array<Column<TRow>>;
</script>

<div class="mobile-table__card-root">
  <div class="mobile-table__card-container">
    {#if columns[0].key === 'images'}
    <div class="mobile-table__card-image">
      <svelte:component this={columns[0].Cell} value={row[columns[0].key]} column={columns[0]} origin={row} />
    </div>
    {/if}
    <div class="mobile-table__card-rows">
      {#each columns.slice(columns[0].key === 'images' ? 1 : 0, columns.length - 1) as column}
        <Row {column} {row} value={row[column.key]} />
      {/each}
    </div>
  </div>
  <div class="mobile-table__card-actions">
    <svelte:component this={columns[columns.length - 1].Cell} value={row[columns[columns.length - 1].key]} column={columns[columns.length - 1]} origin={row} />
  </div>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  
  .mobile-table__card {
    &-root {
      padding: 16px 24px;
      display: flex;
      flex-direction: column;
      border: 1px solid var(--uni-divider-color);
      border-radius: 8px;
      background-color: var(--uni-bg);
    }

    &-container {
      display: flex;
      gap: 16px;
      flex-direction: column;
      
      @include respond-to("smallTablet") {
        flex-direction: row;
      }
    }

    &-image {
      max-width: 50%;
      margin: 0 auto;

      @include respond-to("smallTablet") {
        width: 100%;
        max-width: max(min(30%, 200px), 100px);
        flex-shrink: 0;
        overflow: hidden;
        display: flex;
        height: fit-content;
      }
    }

    &-rows {
      display: flex; 
      flex-direction: column; 
      gap: 8px; 
      flex-grow: 1; 
      margin-bottom: 24px; 
      

      @include respond-to("smallTablet") {
        width: 0;
      }
    }

    &-actions {
      display: flex;
      max-width: fit-content;
      margin-left: auto;
    }
  }

  :global(.mobile-table__card-root .mobile-table__row-root:not(:last-child)) {
    border-bottom: 1px solid var(--uni-divider-color);
  }
</style>
