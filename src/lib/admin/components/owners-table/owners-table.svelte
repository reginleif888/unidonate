<script lang="ts">
  import { useOwners } from "$lib/admin/queries";
  import { Table } from "$lib/common/components";
  import { authClientStore } from "$lib/common/stores";

  import { columns } from "./owners-table.constant";
  import { CreateOwnerForm } from "../create-owner-form";
  import { mapOwnerToForm } from "$lib/admin/mappers";
  import YourPrincipal from "../your-principal.svelte";

  let ownersQuery: ReturnType<typeof useOwners>;

  $: {
    if ($authClientStore) {
      ownersQuery = useOwners($authClientStore?.getIdentity().getPrincipal());
    }
  }
</script>

<div class="owners-table">
  <div class="owners-table__header">
    <h4 class="h4">Owners</h4>

    <div class="owners-table__your-principal">
      <YourPrincipal />
    </div>
  </div>
  <div class="owners-table__top-controls">
    <div class="owners-table__top-controls-left">
      <CreateOwnerForm />
    </div>
  </div>

  <div class="owners-table__table-wrapper">
    <Table
      hiddenHeader
      {columns}
      rows={($ownersQuery?.data ?? []).map(mapOwnerToForm)}
      loadingRowsCount={1}
      loading={$ownersQuery?.isLoading}
      stickyHead
    />
  </div>
</div>

<style lang="scss">
  .owners-table {
    width: 100%;
    display: flex;
    flex-direction: column;
    flex-grow: 1;

    &__header {
      padding: 16px;
      display: flex;
      gap: 16px;
      align-items: center;
      padding-bottom: 0px;
      background-color: var(--uni-bg);
    }

    &__top-controls-left {
      display: flex;
      gap: 16px;
      width: 100%;
      align-items: flex-end;
    }

    &__top-controls {
      position: sticky;
      top: 0;
      padding: 16px;
      background-color: var(--uni-bg);
      border-bottom: 1px solid var(--uni-divider-color);
      z-index: 2;
      display: flex;
      justify-content: flex-start;
      align-items: flex-end;
      gap: 16px;
    }

    &__table-wrapper {
      flex-grow: 1;
      height: 0;
      display: flex;
      flex-direction: column;
      overflow: scroll;
      background-color: var(--uni-bg-transparent-700);
    }

    &__your-principal {
      flex-grow: 1;
      margin-left: auto;
    }
  }
</style>
