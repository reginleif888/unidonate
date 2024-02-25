<script lang="ts" generics="T extends UniqueIdentifier, TRow extends IRow<T>">
  import { MobileTable } from "./mobile";

  import { styleObjectToString } from "$lib/common/utils";

  import { type UniqueIdentifier } from "$lib/common/types";
  import type { Column, Row as IRow } from "./table.types";
  import Row from "./row.svelte";
  import { columnsToMap } from "./table.utils";

  export let rows: Array<TRow>;
  export let columns: Array<Column<TRow>>;
  export let loading: boolean = false;
  export let loadingRowsCount: number = 10;
  export let headerHeight: number | null = null;
  export let stickyHead: boolean = false;
  export let stickyTop: number = 0;
  export let hiddenHeader: boolean = false;
  export let mobile: boolean = false;

  let thElements: HTMLElement[] = [];

  function startResize(event: MouseEvent, index: number) {
    const th = thElements[index];
    const startX = event.pageX;
    const startWidth = th.offsetWidth;

    function doResize(event: MouseEvent) {
      const newWidth = startWidth + event.pageX - startX;
      th.style.width = `${newWidth}px`;
    }

    function stopResize() {
      window.removeEventListener("mousemove", doResize);
      window.removeEventListener("mouseup", stopResize);
    }

    window.addEventListener("mousemove", doResize);
    window.addEventListener("mouseup", stopResize);
  }

  const fakeRow: TRow = {} as TRow;

  $: columnsMap = columnsToMap(columns);
</script>

{#if mobile}
  <MobileTable {columns} {rows} />
{/if}

{#if !mobile}
  <div class="table-root">
    <table class="table-root__table">
      {#if !hiddenHeader}
        <thead
          class="table-root__head"
          class:table-root__head--sticky={stickyHead}
          style={styleObjectToString({
            top: stickyTop ? `${stickyTop}px` : "0px",
            height: headerHeight ? `${headerHeight}px` : "unset",
          })}
        >
          <tr class="table-root__row">
            {#each columns as column, index (column.key)}
              <th
                class="table-root__head-cell subtitle2"
                style={styleObjectToString({
                  textAlign: column.align,
                  width: column.width ? `${column.width}px` : undefined,
                  minWidth: column.minWidth
                    ? `${column.minWidth}px`
                    : undefined,
                  maxWidth: column.maxWidth
                    ? `${column.maxWidth}px`
                    : undefined,
                })}
                bind:this={thElements[index]}
                >{column.label}
                <button
                  class="table-root__resizer"
                  on:mousedown={(event) => startResize(event, index)}
                /></th
              >
            {/each}
          </tr>
        </thead>
      {/if}

      <tbody class="table-root__body">
        {#if !loading}
          {#each rows as row (row.id)}
            <Row {row} {columnsMap} />
          {/each}
        {/if}

        {#if loading}
          {#each Array(loadingRowsCount) as _, index}
            <Row row={fakeRow} {loading} {columnsMap} />
          {/each}
        {/if}
      </tbody>
    </table>
  </div>
{/if}

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
      padding: 8px;
      text-align: center;
      font-weight: 700;
      position: relative;
    }

    &__resizer {
      cursor: col-resize;
      position: absolute;
      top: 0;
      right: 0;
      width: 3px;
      height: 100%;
      background-color: var(--uni-primary-transparent-20);
      border: unset;
      padding: 0;
    }
  }

  :global(.table-root .row:not(:last-child)) {
    border-bottom: 1px solid var(--uni-divider-color);
  }
</style>
