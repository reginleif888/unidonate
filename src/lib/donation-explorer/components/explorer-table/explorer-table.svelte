<script lang="ts">
  import { Table, Pagination, Select, Button } from "$lib/common/components";
  import InputWithLabel from "$lib/common/components/input-with-label.svelte";
  import { PAGE_SIZES_SELECT_ITEMS } from "$lib/donate/constant";
  import { MagnifyingGlass } from "phosphor-svelte";
  import { columns, orderByOptions } from "./explorer-table.constant";
  import { donationsMock } from "$lib/donation-explorer/mocks";

  let topControlsElement: HTMLElement | null = null;
</script>

<div class="explorer-table">
  <div class="explorer-table__header">
    <h4 class="h4">Donation explorer</h4>
    <p class="body1">
      Here, you can explore the complete history of donations.
    </p>
  </div>

  <div class="explorer-table__top-controls" bind:this={topControlsElement}>
    <div class="explorer-table__order-by-select">
      <InputWithLabel label="Order by">
        <Select items={orderByOptions} />
      </InputWithLabel>
    </div>
    <Button label="Search donation">
      <div slot="start-icon" class="explorer-table__magnify-glass">
        <MagnifyingGlass size={20} />
      </div>
    </Button>
  </div>

  <div class="explorer-table__table-wrapper">
    <Table
      {columns}
      rows={donationsMock}
      stickyHead
      stickyTop={topControlsElement?.clientHeight}
    />
  </div>
</div>
<div class="explorer-table__bottom-controls">
  <div class="explorer-table__bottom-controls-select">
    <InputWithLabel label="Per page">
      <Select items={PAGE_SIZES_SELECT_ITEMS} />
    </InputWithLabel>
  </div>

  <Pagination count={50} />
</div>

<style lang="scss">
  .explorer-table {
    width: 100%;
    display: flex;
    flex-direction: column;
    flex-grow: 1;

    &__header {
      padding: 24px;
      display: flex;
      flex-direction: column;
      gap: 16px;
      padding-bottom: 0px;
      background-color: var(--uni-bg);
    }

    &__order-by-select {
      max-width: 240px;
      width: 100%;
    }

    &__top-controls {
      position: sticky;
      top: 0;
      padding: 24px;
      background-color: var(--uni-bg);
      border-bottom: 1px solid var(--uni-divider-color);
      z-index: 2;
      display: flex;
      justify-content: flex-start;
      align-items: flex-end;
      gap: 16px;
    }

    &__bottom-controls {
      display: flex;
      justify-content: flex-start;
      align-items: flex-end;
      padding: 24px;
      gap: 16px;
      position: sticky;
      bottom: 0;
      background-color: var(--uni-bg);
      border-top: 1px solid var(--uni-divider-color);
    }

    &__bottom-controls-select {
      max-width: 120px;
      width: 100%;
    }

    &__magnify-glass {
      position: relative;
      top: 2px;
    }

    &__table-wrapper {
      flex-grow: 1;
      background-color: var(--uni-bg-transparent-700);
    }
  }
</style>
