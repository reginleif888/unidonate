<script lang="ts">
  import {
    Table,
    Pagination,
    Select,
    Button,
    Input,
  } from "$lib/common/components";
  import InputWithLabel from "$lib/common/components/input-with-label.svelte";
  import { PAGE_SIZES_SELECT_ITEMS } from "$lib/donate/constant";
  import { MagnifyingGlass } from "phosphor-svelte";
  import { columns } from "./schools-table.constant";
  import { adminSchoolsMock } from "$lib/admin/mocks";

  export let onSearchDonation: () => void = () => null;

  let topControlsElement: HTMLElement | null = null;
</script>

<div class="explorer-table">
  <div class="explorer-table__top-controls" bind:this={topControlsElement}>
    <div class="explorer-table__top-controls-left">
      <div class="explorer-table__order-by-select">
        <InputWithLabel label="Search">
          <Input placeholder="Your school..." />
        </InputWithLabel>
      </div>
    </div>
  </div>

  <div class="explorer-table__table-wrapper">
    <Table
      {columns}
      rows={adminSchoolsMock}
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

    &__allocation-legends {
      display: grid;
      grid-template-columns: 1fr 1fr;
      grid-template-rows: auto auto;
      text-align: center;
      gap: 8px;
      width: 400px;
      border: 1px solid var(--uni-divider-color);
      padding: 8px;
      border-radius: 16px;
      box-shadow: var(--uni-shadow-paper);
    }

    &__header {
      padding: 24px;
      display: flex;
      flex-direction: column;
      gap: 16px;
      padding-bottom: 0px;
      background-color: var(--uni-bg);
    }

    &__top-controls-left {
      display: flex;
      gap: 16px;
      width: 100%;
      align-items: flex-end;
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
