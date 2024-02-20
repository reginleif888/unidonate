<script lang="ts">
  import {
    Table,
    Pagination,
    Select,
    Input,
    Switch,
    Button,
    Tooltip,
  } from "$lib/common/components";
  import InputWithLabel from "$lib/common/components/input-with-label.svelte";
  import { PAGE_SIZES_SELECT_ITEMS } from "$lib/donate/constant";

  import { columns } from "./schools-table.constant";
  import { adminSchoolsMock } from "$lib/admin/mocks";
  import { MagnifyingGlass, Plus, DownloadSimple } from "phosphor-svelte";
  import SchoolModal from "../school-modal.svelte";

  let topControlsElement: HTMLElement | null = null;

  let search = "";

  let timerId: NodeJS.Timeout;

  let loading: boolean = false;

  let schoolModalOpen: boolean = false;

  function openSchoolModal() {
    schoolModalOpen = true;
  }

  function closeSchoolModal() {
    schoolModalOpen = false;
  }

  $: {
    loading = true;

    clearTimeout(timerId);

    timerId = setTimeout(() => {
      loading = false;
    }, 1000);
  }
</script>

<div class="schools-table">
  <div class="schools-table__header">
    <h4 class="h4">Schools</h4>
  </div>
  <div class="schools-table__top-controls" bind:this={topControlsElement}>
    <div class="schools-table__top-controls-left">
      <div class="schools-table__search-select">
        <InputWithLabel label="Search">
          <Input placeholder="Your school..." bind:value={search}>
            <span slot="end-icon" class="schools-table__magnify-glass">
              <MagnifyingGlass size={20} />
            </span>
          </Input>
        </InputWithLabel>
      </div>
      <div class="schools-table__add-button-wrapper">
        <Tooltip>
          <span slot="trigger">
            <Button contained onlyIcon on:click={openSchoolModal}>
              <div slot="start-icon" class="schools-table__add-button-icon">
                <Plus size={24} weight="bold" />
              </div>
            </Button>
          </span>
          <span slot="content"> Add new </span>
        </Tooltip>
      </div>
      <div class="schools-table__toggle-active-wrapper">
        <InputWithLabel label="Active" rowView>
          <Switch />
        </InputWithLabel>
      </div>
    </div>

    <div class="schools-table__top-controls-right">
      <div class="schools-table__import-wrapper">
        <Button contained label="Import">
          <div slot="start-icon" class="schools-table__import-icon">
            <DownloadSimple size={24} weight="bold" />
          </div>
        </Button>
      </div>
    </div>
  </div>

  <div class="schools-table__table-wrapper">
    <Table {columns} rows={adminSchoolsMock} stickyHead {loading} />
  </div>
</div>
<div class="schools-table__bottom-controls">
  <div class="schools-table__bottom-controls-select">
    <InputWithLabel label="Per page">
      <Select items={PAGE_SIZES_SELECT_ITEMS} />
    </InputWithLabel>
  </div>

  <Pagination count={50} />
</div>

<SchoolModal bind:open={schoolModalOpen} on:close={closeSchoolModal} />

<style lang="scss">
  .schools-table {
    width: 100%;
    display: flex;
    flex-direction: column;
    flex-grow: 1;

    &__header {
      padding: 16px;
      display: flex;
      flex-direction: column;
      padding-bottom: 0px;
      background-color: var(--uni-bg);
    }

    &__top-controls-left {
      display: flex;
      gap: 16px;
      width: 100%;
      align-items: flex-end;
    }

    &__search-select {
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
      background-color: var(--uni-bg);
      border-top: 1px solid var(--uni-divider-color);
    }

    &__bottom-controls-select {
      max-width: 120px;
      width: 100%;
    }

    &__toggle-active-wrapper {
      margin-bottom: 6px;
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
