<script lang="ts" generics="T extends UniqueIdentifier">
  import { type UniqueIdentifier } from "$lib/common/types";
  import type { Column, Row as IRow } from "./table.types";
  import Row from "./row.svelte";
  import { columnsToMap } from "./table.utils";

  export let columns: Array<Column> = [];
  export let rows: Array<IRow<T>> = [];
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
            class:table-root__head-cell--left={column.align === "left"}
            class:table-root__head-cell--right={column.align === "right"}
            class:table-root__head-cell--center={column.align === "center"}
            >{column.label}</th
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
      box-shadow: 0 4px 6px -2px rgba(0, 0, 0, 0.2);

      &--sticky {
        position: sticky;
        z-index: 1;
      }
    }

    &__head-cell {
      padding: 16px;
      text-align: center;

      &--left {
        text-align: left;
      }

      &--right {
        text-align: right;
      }

      &--center {
        text-align: center;
      }
    }
  }

  :global(.table-root .row:not(:last-child)) {
    border-bottom: 1px solid var(--uni-divider-color);
  }
</style>
