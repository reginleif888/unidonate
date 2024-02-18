<script lang="ts" generics="TRow extends IRow<UniqueIdentifier>">
  import { type UniqueIdentifier } from "$lib/common/types";
  import { type Row as IRow } from "./table.types";
  import type { Column as IColumn } from "./table.types";

  export let value: TRow[keyof TRow];
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
    {value}
  {/if}
</td>

<style lang="scss">
  .cell {
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

    &__inner {
      padding: 24px;
    }
  }
</style>
