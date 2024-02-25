<script lang="ts">
  import {
    Table,
    Pagination,
    Select,
    Input,
    Switch,
    Button,
    Tooltip,
    InputWithLabel,
  } from "$lib/common/components";
  import { PAGE_SIZES_SELECT_ITEMS } from "$lib/donate/constant";

  import { columns } from "./schools-table.constant";
  import {
    MagnifyingGlass,
    Plus,
    DownloadSimple,
    FileCsv,
  } from "phosphor-svelte";
  import SchoolModal from "../school-modal";
  import { useCreateSchool, useSchools } from "$lib/admin/queries";
  import { mapSchoolToForm } from "$lib/admin/mappers";
  import type {
    AddSchoolPayload,
    GetSchoolsPayload,
  } from "../../../../declarations/backend/backend.did";
  import { debounce, wait } from "$lib/common/utils";
  import { EntityImportModal } from "../entity-import-modal";
  import type { ColumnMapping } from "$lib/admin/utils";
  import { screenWidthStore, snackbarStore } from "$lib/common/stores";
  import YourPrincipal from "../your-principal.svelte";
  import { SCREEN } from "$lib/common/constant";

  let search = "";

  let perPage = PAGE_SIZES_SELECT_ITEMS[3];

  let page: number = 1;

  let active: boolean = false;

  let createModalOpen: boolean = false;

  let importModalOpen: boolean = false;

  let progressLabel: string = "";

  let progress: number = 0;

  function openCreateModal() {
    createModalOpen = true;
  }

  function closeCreateModal() {
    createModalOpen = false;
  }

  function openImportModal() {
    importModalOpen = true;
  }

  function closeImportModal() {
    importModalOpen = false;
  }

  function handleResetPage() {
    page = 1;
  }

  let query: GetSchoolsPayload = {
    filters: {
      schoolName: search,
      active: active,
    },
    page: (Number(page) - 1) as unknown as bigint,
    perPage: Number(perPage.value) as unknown as bigint,
  };

  const [debounced] = debounce(() => {
    query = {
      filters: {
        schoolName: search,
        active: active,
      },
      page: (Number(page) - 1) as unknown as bigint,
      perPage: Number(perPage.value) as unknown as bigint,
    };
  }, 300);

  $: [search, page, perPage, active], debounced();

  $: schoolsQuery = useSchools(query);

  const createSchool = useCreateSchool({ withoutSuccessSnackbar: true });

  const columnMapping: Array<ColumnMapping> = [
    {
      index: 0,
      fieldName: "name",
      required: true,
    },
    {
      index: 1,
      fieldName: "website",
      required: true,
    },
    {
      index: 2,
      fieldName: "location",
      required: true,
    },
    {
      index: 3,
      fieldName: "img",
      img: true,
    },
  ];

  function dataMapper(row: Record<string, any>): AddSchoolPayload {
    return {
      name: row.name,
      location: row.location,
      website: row.website,
      images: row.image ? [[row.image]] : [],
    };
  }

  async function handleImport(data: Array<AddSchoolPayload>) {
    let i = 0;

    let dots = 0;

    let successNumber = 0;

    const timer = setInterval(() => {
      dots = (dots + 1) % 4;

      const dotsStr = `${".".repeat(dots)}`;

      progressLabel = `Schools importing${dotsStr}\t${i + 1}/${data.length}`;
    }, 250);

    for (i = 0; i < data.length; i++) {
      try {
        const school = data[i];

        await $createSchool.mutateAsync(school);

        successNumber = successNumber + 1;
      } catch (error) {}

      progress = 15 + (85 * (i + 1)) / data.length;
    }

    clearInterval(timer);

    progressLabel = "Done 🏁";

    await wait(1000);

    if (successNumber) {
      snackbarStore.addMessage({
        type: "success",
        message: `${successNumber}/${data.length} schools were successfully imported! 🎉🎉🎉`,
      });
    }

    progressLabel = "";
  }

  function handleExampleDownload() {
    const fileUrl = "/schools_example.csv";

    const link = document.createElement("a");

    link.href = fileUrl;

    link.download = "schools_example";

    document.body.appendChild(link);

    link.click();

    document.body.removeChild(link);
  }
</script>

<div class="schools-table">
  <div class="schools-table__header">
    <h4 class="h4">Schools</h4>

    <div class="schools-table__your-principal">
      <YourPrincipal />
    </div>
  </div>
  <div class="schools-table__top-controls">
    <div class="schools-table__top-controls-left">
      <div class="schools-table__search-select">
        <InputWithLabel label="Search">
          <Input
            placeholder="Your school..."
            bind:value={search}
            on:input={handleResetPage}
          >
            <span slot="end-icon" class="schools-table__magnify-glass">
              <MagnifyingGlass size={20} />
            </span>
          </Input>
        </InputWithLabel>
      </div>

      <div class="schools-table__add-button-wrapper">
        <Tooltip>
          <span slot="trigger">
            <Button contained onlyIcon on:click={openCreateModal}>
              <div slot="start-icon" class="schools-table__add-button-icon">
                <Plus size={24} weight="bold" />
              </div>
            </Button>
          </span>
          <span slot="content"> Add new </span>
        </Tooltip>
      </div>
      <div class="schools-table__toggle-active-wrapper">
        <InputWithLabel label="Only active" rowView>
          <Switch bind:checked={active} on:change={handleResetPage} />
        </InputWithLabel>
      </div>
    </div>

    <div class="schools-table__top-controls-right">
      <div class="schools-table__import-wrapper">
        <Button
          contained
          label="Download example"
          on:click={handleExampleDownload}
        >
          <div slot="start-icon" class="schools-table__import-icon">
            <FileCsv size={24} weight="bold" />
          </div>
        </Button>
        <Button contained label="Import" on:click={openImportModal}>
          <div slot="start-icon" class="schools-table__import-icon">
            <DownloadSimple size={24} weight="bold" />
          </div>
        </Button>
      </div>
    </div>
  </div>

  <div class="schools-table__table-wrapper">
    <Table
      {columns}
      rows={$schoolsQuery.data?.schools.map(mapSchoolToForm) ?? []}
      stickyHead
      loadingRowsCount={Number(perPage.label)}
      mobile={$screenWidthStore < SCREEN.desktop}
    />
    {#if !$schoolsQuery.data?.schools.length && !$schoolsQuery.isLoading}
      <div class="schools-table__empty-placeholder h5">
        No schools have been added yet
      </div>
    {/if}
  </div>
</div>
<div class="schools-table__bottom-controls">
  <div class="schools-table__bottom-controls-select">
    <InputWithLabel label="Per page">
      <Select
        items={PAGE_SIZES_SELECT_ITEMS}
        bind:selected={perPage}
        on:change={handleResetPage}
        size={$screenWidthStore < SCREEN.desktop ? "small" : "medium"}
      />
    </InputWithLabel>
  </div>

  {#if Number($schoolsQuery.data?.total) > Number(perPage.value)}
    <Pagination
      count={Number($schoolsQuery.data?.total)}
      bind:currentPage={page}
      perPage={Number(perPage.value)}
      mobile={$screenWidthStore < SCREEN.desktop}
    />
  {/if}
</div>

<SchoolModal bind:open={createModalOpen} on:close={closeCreateModal} />

<EntityImportModal
  title="Import schools"
  {columnMapping}
  {dataMapper}
  bind:progress
  bind:progressLabel
  onImport={handleImport}
  bind:open={importModalOpen}
  on:close={closeCreateModal}
  on:close={closeImportModal}
/>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .schools-table {
    width: 100%;
    display: flex;
    flex-direction: column;
    flex-grow: 1;

    &__header {
      display: flex;
      padding: 8px;
      gap: 8px;
      align-items: center;
      padding-bottom: 0px;
      background-color: var(--uni-bg);

      @include respond-to("desktop") {
        padding: 16px;
        gap: 16px;
      }
    }

    &__top-controls-left {
      display: flex;
      gap: 8px;
      width: 100%;
      align-items: flex-end;

      @include respond-to("desktop") {
        gap: 16px;
      }
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
      padding: 0 3px;
    }

    &__import-icon {
      position: relative;
      top: 2px;
    }

    &__top-controls {
      position: sticky;
      top: 0;
      padding: 8px;
      gap: 8px;
      background-color: var(--uni-bg);
      border-bottom: 1px solid var(--uni-divider-color);
      z-index: 2;
      display: flex;
      flex-direction: column;
      justify-content: flex-start;
      align-items: flex-end;

      @include respond-to("desktop") {
        padding: 16px;
        gap: 16px;
        flex-direction: row;
      }
    }

    &__bottom-controls {
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      padding: 8px;
      gap: 8px;
      background-color: var(--uni-bg);
      border-top: 1px solid var(--uni-divider-color);

      @include respond-to("desktop") {
        padding: 16px;
        gap: 16px;
        justify-content: flex-start;
      }
    }

    &__bottom-controls-select {
      max-width: 120px;
      width: 100%;
    }

    &__toggle-active-wrapper {
      margin-bottom: 3px;

      @include respond-to("desktop") {
        margin-bottom: 6px;
      }
    }

    &__magnify-glass {
      position: relative;
      top: 2px;
    }

    &__table-wrapper {
      flex-grow: 1;
      height: 0;
      display: flex;
      flex-direction: column;
      overflow: scroll;
      background-color: var(--uni-bg-transparent-700);
    }

    &__import-wrapper {
      display: flex;
      gap: 4px;
      justify-content: space-between;

      @include respond-to("desktop") {
        gap: 8px;
        justify-content: flex-end;
      }
    }

    &__top-controls-right {
      width: 100%;
    }

    &__empty-placeholder {
      width: 100%;
      flex-grow: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      font-weight: 500;
      color: var(--uni-text-color-400);
    }

    &__your-principal {
      flex-grow: 1;
      margin-left: auto;
    }
  }
</style>
