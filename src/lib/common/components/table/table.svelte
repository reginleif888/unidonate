<script lang="ts" generics="T extends UniqueIdentifier, TRow extends IRow<T>">
  import { styleObjectToString } from "$lib/common/utils";

  import { type UniqueIdentifier } from "$lib/common/types";
  import type { Column, Row as IRow } from "./table.types";
  import Row from "./row.svelte";
  import { columnsToMap } from "./table.utils";

  export let rows: Array<TRow>;
  export let columns: Array<Column<TRow>>;

  export let stickyHead: boolean = false;
  export let stickyTop: number = 0;

  $: columnsMap = columnsToMap(columns);
</script>

<div class="table-root">
  <table class="table-root__table">
    <thead
      class="table-root__head"
      class:table-root__head--sticky={stickyHead}
      style={`top: ${stickyTop}px`}
    >
      <tr class="table-root__row">
        {#each columns as column (column.key)}
          <th
            class="table-root__head-cell subtitle2"
            style={styleObjectToString({
              textAlign: column.align,
            })}>{column.label}</th
          >
        {/each}
      </tr>
    </thead>
    <tbody class="table-root__body">
      {#each rows as row (row.id)}
        <Row {row} {columnsMap} />
      {/each}
    </tbody>
  </table>
</div>

<style lang="scss">
  .table-root {
    width: 100%;
    border-collapse: collapse;
    border-spacing: 0;

    &__table {
      width: 100%;
    }

    &__head {
      border-bottom: 1px solid var(--uni-divider-color);
      background-color: var(--uni-secondary);
      box-shadow: var(--uni-shadow-table-head);

      &--sticky {
        position: sticky;
        z-index: 1;
      }
    }

    &__head-cell {
      padding: 16px;
      text-align: center;
      font-weight: 700;
    }
  }

  :global(.table-root .row:not(:last-child)) {
    border-bottom: 1px solid var(--uni-divider-color);
  }
</style>
