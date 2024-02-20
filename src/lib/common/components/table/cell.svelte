<script lang="ts" generics="TRow extends IRow<UniqueIdentifier>">
  import { type UniqueIdentifier } from "$lib/common/types";
  import { TruncatedText } from "$lib/common/components";
  import { type Row as IRow } from "./table.types";
  import type { Column as IColumn } from "./table.types";

  export let value: TRow[keyof TRow] = "" as TRow[keyof TRow];
  export let row: TRow;
  export let column: IColumn<TRow>;
  export let loading: boolean = false;

  let renderMethod: "value" | "format" | "component" = "value";

  $: {
    if (column?.Cell) {
      renderMethod = "component";
    } else if (column?.format) {
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
  <div
    class="cell__inner"
    class:cell__inner--left={column.align === "left"}
    class:cell__inner--right={column.align === "right"}
    class:cell__inner--center={column.align === "center"}
    class:cell__inner--actions={column.key === "actions"}
  >
    {#if loading}
      <div class="cell__cell-skeleton"></div>
    {/if}

    {#if !loading}
      {#if renderMethod === "format" && column.format}
        <TruncatedText
          text={column.format(value, row)}
          withCopy={column.rowTooltipWithCopyOption}
        />
      {/if}
      {#if renderMethod === "component" && column.Cell}
        <svelte:component this={column.Cell} {value} {column} origin={row} />
      {/if}
      {#if renderMethod === "value"}
        <TruncatedText
          text={value}
          withCopy={column.rowTooltipWithCopyOption}
        />
      {/if}
    {/if}
  </div>
</td>

<style lang="scss">
  .cell {
    text-align: center;
    position: relative;
    height: 60px;

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
      padding: 8px;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
      width: 100%;

      display: flex;
      align-items: center;
      justify-content: center;

      &--left {
        justify-content: flex-start;
      }

      &--right {
        justify-content: flex-end;
      }

      &--center {
        justify-content: center;
      }
    }

    &__cell-skeleton {
      width: 100%;
      height: 80%;
      border-radius: 16px;
      animation: skeleton-pulse 1.5s infinite ease-in-out;
    }
  }
</style>
