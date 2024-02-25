<script lang="ts" generics="T extends UniqueIdentifier, TRow extends IRow<T>">
  import { type UniqueIdentifier } from "$lib/common/types";
  import Row from "../row.svelte";
  import { type Column, type Row as IRow } from "../table.types";
  import { TruncatedText } from "$lib/common/components";

  export let row: TRow;
  export let column: Column<TRow>;
  export let value: string;

  let renderMethod: "value" | "format" | "component" = "value";

  $: {
    if (column?.Cell) {
      renderMethod = "component";
    } else if (column?.format) {
      renderMethod = "format";
    }
  }
</script>

<div class="mobile-table__row-root body2">
  {#if column.label}
    <div class="mobile-table__column-label">{column.label}</div>
  {/if}

  <div class="mobile-table__column-value">
    {#if renderMethod === "format" && column.format}
      <TruncatedText
        text={column.format(value, row)}
        withCopy={column.rowTooltipWithCopyOption}
        align={column.align}
      />
    {/if}
    {#if renderMethod === "component" && column.Cell}
      <svelte:component this={column.Cell} {value} {column} origin={row} />
    {/if}
    {#if renderMethod === "value"}
      <TruncatedText
        text={value}
        withCopy={column.rowTooltipWithCopyOption}
        align={column.align}
      />
    {/if}
  </div>
</div>

<style>
  .mobile-table__row-root {
    display: flex;
  }

  .mobile-table__column-label {
    font-weight: bold;
    border-right: 1px solid var(--uni-divider-color);
    flex: 1 1 50%;
    padding: 8px;
    min-width: 50%;
  }

  .mobile-table__column-value {
    padding: 8px;
    flex: 1 1 50%;
    min-width: 50%;
    display: flex;
    justify-content: center;
  }
</style>
