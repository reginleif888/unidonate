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
    <div class="mobile-table__column-label">{column.label}: </div>
  {/if}

  <div class="mobile-table__column-value">
    {#if renderMethod === "format" && column.format}
      <TruncatedText
        text={column.format(value, row)}
        withCopy={column.rowTooltipWithCopyOption}
        align={"right"}
      />
    {/if}
    {#if renderMethod === "component" && column.Cell}
      <div class="mobile-table__column-wrapper">
        <svelte:component this={column.Cell} {value} {column} origin={row} />
      </div>
    {/if}
    {#if renderMethod === "value"}
      <TruncatedText
        text={value}
        withCopy={column.rowTooltipWithCopyOption}
        align={"right"}
      />
    {/if}
  </div>
</div>

<style>
  .mobile-table__row-root {
    display: flex;
    gap: 16px;
  }

  .mobile-table__column-value {
    flex-grow: 1;
    overflow: hidden;
  }

  .mobile-table__column-wrapper {
    max-width: fit-content;
    margin-left: auto;
    padding: 2px 0;
  } 
</style>
