<script lang="ts" generics="TRow extends IRow<UniqueIdentifier>">
  import { type UniqueIdentifier } from "$lib/common/types";
  import { type Row as IRow } from "./table.types";
  import type { Column as IColumn } from "./table.types";

  export let value: TRow[keyof TRow] = "" as TRow[keyof TRow];
  export let row: TRow;
  export let column: IColumn<TRow>;

  let renderMethod: "value" | "format" | "component" = "value";

  $: {
    if (column.Cell) {
      renderMethod = "component";
    } else if (column.format) {
      renderMethod = "format";
    }
  }
</script>

<td
  class="cell body2"
  class:cell--left={column.align === "left"}
  class:cell--right={column.align === "right"}
  class:cell--center={column.align === "center"}
  class:cell--actions={column.key === "actions"}
>
  {#if renderMethod === "format" && column.format}
    <div class="cell__inner">
      {column.format(value, row)}
    </div>
  {/if}

  {#if renderMethod === "component" && column.Cell}
    <div class="cell__inner">
      <svelte:component this={column.Cell} {value} {column} origin={row} />
    </div>
  {/if}

  {#if renderMethod === "value"}
    <div class="cell__inner">
      {value}
    </div>
  {/if}
</td>

<style lang="scss">
  .cell {
    text-align: center;
    position: relative;
    height: 80px;

    &--actions {
      width: 100px;
      background-color: var(--uni-bg-transparent-300);
    }

    &--left {
      text-align: left;
    }

    &--right {
      text-align: right;
    }

    &--center {
      text-align: center;
    }

    &__inner {
      position: absolute;
      top: 0;
      left: 0;
      bottom: 0;
      right: 0;
      padding: 24px;
      line-height: 32px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      width: 100%;
    }
  }
</style>
