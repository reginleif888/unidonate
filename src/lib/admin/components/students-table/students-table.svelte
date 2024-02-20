<script lang="ts">
  import {
    Table,
    Pagination,
    Select,
    Input,
    Tooltip,
    Button,
    Switch,
  } from "$lib/common/components";
  import InputWithLabel from "$lib/common/components/input-with-label.svelte";
  import { PAGE_SIZES_SELECT_ITEMS } from "$lib/donate/constant";
  import { columns } from "./students-table-constant";
  import { adminStudentsMock } from "$lib/admin/mocks";
  import {
    MagnifyingGlass,
    CaretLeft,
    Plus,
    DownloadSimple,
  } from "phosphor-svelte";
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
      <div class="students-table__search">
        <InputWithLabel label="Search">
          <Input placeholder="Your student...">
            <span slot="end-icon" class="students-table__magnify-glass">
              <MagnifyingGlass size={20} />
            </span>
          </Input>
        </InputWithLabel>
      </div>
      <div class="students-table__add-button-wrapper">
        <Tooltip>
          <span slot="trigger">
            <Button contained onlyIcon>
              <div slot="start-icon" class="students-table__add-button-icon">
                <Plus size={24} weight="bold" />
              </div>
            </Button>
          </span>
          <span slot="content"> Add new </span>
        </Tooltip>
      </div>
      <div class="students-table__toggle-active-wrapper">
        <InputWithLabel label="Active" rowView>
          <Switch />
        </InputWithLabel>
      </div>
    </div>

    <div class="students-table__top-controls-right">
      <div class="students-table__import-wrapper">
        <Button contained label="Import">
          <div slot="start-icon" class="students-table__import-icon">
            <DownloadSimple size={24} weight="bold" />
          </div>
        </Button>
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

    &__search {
      max-width: 240px;
      width: 100%;
    }

    &__add-button-wrapper {
      color: var(--uni-on-primary);
      display: flex;
      align-items: center;
    }

    &__add-button-icon {
      position: relative;
      top: 2px;
    }

    &__import-icon {
      position: relative;
      top: 2px;
    }

    &__toggle-active-wrapper {
      margin-bottom: 6px;
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
