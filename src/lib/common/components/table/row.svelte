<script lang="ts" generics=" TRow extends IRow<UniqueIdentifier>">
  import { type UniqueIdentifier } from "$lib/common/types";
  import Cell from "./cell.svelte";
  import type { Column as IColumn, Row as IRow } from "./table.types";

  export let row: TRow;

  export let columnsMap: Record<string, IColumn<TRow>>;
</script>

<tr class="row">
  {#each Object.keys(columnsMap) as key (key)}
    <Cell value={row[key]} {row} column={columnsMap[key]} />
  {/each}
</tr>

<style lang="scss">
  .row {
    &:hover {
      background-color: var(--uni-primary-transparent-10);
    }
  }
</style>
