<script lang="ts" generics="T extends UniqueIdentifier">
  import { type UniqueIdentifier } from "$lib/common/types";
  import Cell from "./cell.svelte";
  import type { Column as IColumn, Row as IRow } from "./table.types";

  export let row: IRow<T>;

  export let columnsMap: Record<string, IColumn>;
</script>

<tr class="row">
  {#each Object.keys(columnsMap) as key (key)}
    <Cell value={row[key]} column={columnsMap[key]} />
  {/each}
</tr>

<style lang="scss">
  .row {
    &:hover {
      background-color: var(--uni-primary-transparent-10);
    }
  }
</style>
