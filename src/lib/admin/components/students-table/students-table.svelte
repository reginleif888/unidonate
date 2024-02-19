<script lang="ts">
  import { Table, Pagination, Select, Input } from "$lib/common/components";
  import InputWithLabel from "$lib/common/components/input-with-label.svelte";
  import { PAGE_SIZES_SELECT_ITEMS } from "$lib/donate/constant";
  import { columns } from "./students-table-constant";
  import { adminStudentsMock } from "$lib/admin/mocks";
  import { MagnifyingGlass, CaretLeft } from "phosphor-svelte";
  import { goto } from "$app/navigation";
  import { AdminRoute } from "$lib/common/routes";

  let topControlsElement: HTMLElement | null = null;

  function goToSchools() {
    goto(AdminRoute.Schools);
  }
</script>

<div class="students-table">
  <div class="students-table__header">
    <button class="students-table__back-button" on:click={goToSchools}>
      <CaretLeft size={24} />
    </button>
    <h4 class="h4">Students of Harvard</h4>
  </div>
  <div class="students-table__top-controls" bind:this={topControlsElement}>
    <div class="students-table__top-controls-left">
      <div class="students-table__order-by-select">
        <InputWithLabel label="Search">
          <Input placeholder="Your student...">
            <span slot="end-icon" class="students-table__magnify-glass">
              <MagnifyingGlass size={20} />
            </span>
          </Input>
        </InputWithLabel>
      </div>
    </div>
  </div>

  <div class="students-table__table-wrapper">
    <Table {columns} rows={adminStudentsMock} stickyHead />
  </div>
</div>

<div class="students-table__bottom-controls">
  <div class="students-table__bottom-controls-select">
    <InputWithLabel label="Per page">
      <Select items={PAGE_SIZES_SELECT_ITEMS} />
    </InputWithLabel>
  </div>

  <Pagination count={50} />
</div>

<style lang="scss">
  .students-table {
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
      padding: 16px;
      display: flex;
      gap: 16px;
      align-items: center;
      padding-bottom: 0px;
      background-color: var(--uni-bg);
    }

    &__back-button {
      color: var(--uni-on-bg);
      padding: 0;
      background-color: transparent;
      border: unset;
      cursor: pointer;

      &:hover {
        color: var(--uni-primary);
      }
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
      padding: 16px;
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
      padding: 16px;
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
      height: 0;
      overflow: scroll;
      background-color: var(--uni-bg-transparent-700);
    }
  }
</style>
