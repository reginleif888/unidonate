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
  import {
    MagnifyingGlass,
    CaretLeft,
    Plus,
    DownloadSimple,
    FileCsv,
  } from "phosphor-svelte";
  import { goto } from "$app/navigation";
  import { AdminRoute } from "$lib/common/routes";
  import StudentModal from "../student-modal";
  import { page } from "$app/stores";
  import type {
    AddStudentPayload,
    GetStudentsPayload,
  } from "../../../../declarations/backend/backend.did";
  import { debounce, toBigInt, wait } from "$lib/common/utils";
  import { useCreateStudent, useStudents } from "$lib/admin/queries";
  import { mapStudentToForm } from "$lib/admin/mappers";
  import { EntityImportModal } from "../entity-import-modal";
  import { screenWidthStore, snackbarStore } from "$lib/common/stores";
  import { csvSerialDateToIso, type ColumnMapping } from "$lib/admin/utils";
  import { useQueryClient } from "@sveltestack/svelte-query";
  import YourPrincipal from "../your-principal.svelte";
  import { SCREEN } from "$lib/common/constant";

  let createModalOpen: boolean = false;

  let search = "";

  let perPage = PAGE_SIZES_SELECT_ITEMS[3];

  let currentPage: number = 1;

  let active: boolean = false;

  let importModalOpen: boolean = false;

  let progressLabel: string = "";

  let progress: number = 0;

  const queryClient = useQueryClient();

  function openCreateModal() {
    createModalOpen = true;
  }

  function closeCreateModal() {
    createModalOpen = false;
  }

  function goToSchools() {
    goto(AdminRoute.Schools);
  }

  function openImportModal() {
    importModalOpen = true;
  }

  function closeImportModal() {
    importModalOpen = false;
  }

  let query: GetStudentsPayload & { schoolId: string } = {
    filters: {
      studentName: search,
      active: active,
    },
    page: toBigInt(Number(currentPage) - 1),
    perPage: toBigInt(Number(perPage.value)),
    schoolId: $page.params.schoolId,
  };

  function handleResetPage() {
    currentPage = 1;
  }

  const [debounced] = debounce(() => {
    query = {
      ...query,
      filters: {
        studentName: search,
        active: active,
      },
      page: toBigInt(Number(currentPage) - 1),
      perPage: toBigInt(Number(perPage.value)),
    };
  }, 300);

  $: [search, currentPage, perPage, active], debounced();

  $: studentsQuery = useStudents(query);

  const createStudent = useCreateStudent({
    withoutSuccessSnackbar: true,
    schoolId: $page.params.schoolId,
  });

  const columnMapping: Array<ColumnMapping> = [
    {
      index: 0,
      fieldName: "firstName",
      required: true,
    },
    {
      index: 1,
      fieldName: "lastName",
      required: true,
    },
    {
      index: 2,
      fieldName: "dob",
      required: true,
    },
    {
      index: 3,
      fieldName: "grade",
      required: true,
    },
    {
      index: 4,
      fieldName: "img",
      img: true,
    },
  ];

  function dataMapper(row: Record<string, any>): AddStudentPayload {
    console.log(`${JSON.stringify(row.dob)}`);

    return {
      firstName: row.firstName,
      lastName: row.lastName,
      dateOfBirth: csvSerialDateToIso(Number(row.dob)),
      grade: row.grade,
      images: row.image ? [[row.image]] : [],
    };
  }

  async function handleImport(data: Array<AddStudentPayload>) {
    let i = 0;

    let dots = 0;

    let successNumber = 0;

    const timer = setInterval(() => {
      dots = (dots + 1) % 4;

      const dotsStr = `${".".repeat(dots)}`;

      progressLabel = `Students importing${dotsStr}\t${i + 1}/${data.length}`;
    }, 250);

    for (i = 0; i < data.length; i++) {
      try {
        const student = data[i];

        await $createStudent.mutateAsync(student);

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
        message: `${successNumber}/${data.length} students were successfully imported! 🎉🎉🎉`,
      });
    }

    progressLabel = "";
  }

  function handleExampleDownload() {
    const fileUrl = "/students_example.csv";

    const link = document.createElement("a");

    link.href = fileUrl;

    link.download = "students_example";

    document.body.appendChild(link);

    link.click();

    document.body.removeChild(link);
  }
</script>

<div class="students-table">
  <div class="students-table__header">
    <button class="students-table__back-button" on:click={goToSchools}>
      <CaretLeft size={24} weight="bold" />
    </button>
    <h4 class="h4">Students</h4>

    <div class="students-table__your-principal">
      <YourPrincipal />
    </div>
  </div>
  <div class="students-table__top-controls">
    <div class="students-table__top-controls-left">
      <div class="students-table__search">
        <InputWithLabel label="Search">
          <Input
            placeholder="Your student..."
            bind:value={search}
            on:input={handleResetPage}
          >
            <span slot="end-icon" class="students-table__magnify-glass">
              <MagnifyingGlass size={20} />
            </span>
          </Input>
        </InputWithLabel>
      </div>
      <div class="students-table__add-button-wrapper">
        <Tooltip>
          <span slot="trigger">
            <Button contained onlyIcon on:click={openCreateModal}>
              <div slot="start-icon" class="students-table__add-button-icon">
                <Plus size={24} weight="bold" />
              </div>
            </Button>
          </span>
          <span slot="content"> Add new </span>
        </Tooltip>
      </div>
      <div class="students-table__toggle-active-wrapper">
        <InputWithLabel label="Only active" rowView>
          <Switch bind:checked={active} on:change={handleResetPage} />
        </InputWithLabel>
      </div>
    </div>

    <div class="students-table__top-controls-right">
      <div class="students-table__import-wrapper">
        <Button
          contained
          label="Download example"
          on:click={handleExampleDownload}
        >
          <div slot="start-icon" class="students-table__import-icon">
            <FileCsv size={24} weight="bold" />
          </div>
        </Button>
        <Button contained label="Import" on:click={openImportModal}>
          <div slot="start-icon" class="students-table__import-icon">
            <DownloadSimple size={24} weight="bold" />
          </div>
        </Button>
      </div>
    </div>
  </div>

  <div class="students-table__table-wrapper">
    <Table
      {columns}
      rows={$studentsQuery.data?.students.map(mapStudentToForm) ?? []}
      stickyHead
      mobile={$screenWidthStore < SCREEN.desktop}
    />

    {#if !$studentsQuery.data?.students.length && !$studentsQuery.isLoading}
      <div class="students-table__empty-placeholder h5">
        No students have been added yet
      </div>
    {/if}
  </div>
</div>

<div class="students-table__bottom-controls">
  <div class="students-table__bottom-controls-select">
    <InputWithLabel label="Per page">
      <Select
        items={PAGE_SIZES_SELECT_ITEMS}
        bind:selected={perPage}
        on:change={handleResetPage}
      />
    </InputWithLabel>
  </div>

  {#if Number($studentsQuery.data?.total) > Number(perPage.value)}
    <Pagination
      count={Number($studentsQuery.data?.total)}
      bind:currentPage
      perPage={Number(perPage.value)}
    />
  {/if}
</div>

<EntityImportModal
  title="Import students"
  {columnMapping}
  {dataMapper}
  bind:progress
  bind:progressLabel
  onImport={handleImport}
  bind:open={importModalOpen}
  on:close={closeCreateModal}
  on:close={closeImportModal}
/>

<StudentModal
  bind:open={createModalOpen}
  on:close={closeCreateModal}
  schoolId={$page.params.schoolId}
/>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  .students-table {
    width: 100%;
    display: flex;
    flex-direction: column;
    flex-grow: 1;

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
      overflow: auto;
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
