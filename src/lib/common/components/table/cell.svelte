<script lang="ts">
  import type { Column as IColumn } from "./table.types";

  export let value: string;
  export let column: IColumn;

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
      {column.format(value)}
    </div>
  {/if}

  {#if renderMethod === "component" && column.Cell}
    <div class="cell__inner">
      <svelte:component this={column.Cell} {value} {column} />
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
