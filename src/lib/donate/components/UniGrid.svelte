<script lang="ts">
  import Pagination from "$lib/common/components/Pagination.svelte";
  import TextInput from "$lib/common/components/TextInput.svelte";
  import { MagnifyingGlass } from "phosphor-svelte";
  import { schools } from "../mocks";
  import { mapSchoolsToGridItems } from "../utils";

  import CardGrid from "./CardGrid.svelte";
  import { useUnis } from "../queries/useUnis";
  import Spinner from "$lib/common/components/Spinner.svelte";
  import { debounce } from "$lib/common/utils";

  const handleSelect = () => {
    setTimeout(() => {
      const specialElement = document.getElementById("student-select");

      if (specialElement) {
        specialElement.scrollIntoView({
          behavior: "smooth",
          block: "start",
        });
      }
    }, 300);
  };

  export let uniId: string = "";

  let search = "";

  let perPage = 10;

  let currentPage = 1;

  $: unisQueryResults = useUnis({
    // @ts-ignore
    page: currentPage - 1,
    // @ts-ignore
    perPage: perPage,
    filters: {
      schoolName: search,
    },
  });

  const [debounceSearch] = debounce((value) => {
    search = value;
  }, 500);
</script>

<div class="root">
  <div class="text-input-wrapper">
    <TextInput
      value={search}
      onInput={debounceSearch}
      placeholder="Search..."
      label="Search for university"
    >
      <svelte:fragment slot="end-icon">
        <MagnifyingGlass size={24} />
      </svelte:fragment>
    </TextInput>
  </div>
  <div class="grid-wrapper">
    <CardGrid
      items={mapSchoolsToGridItems($unisQueryResults.data?.schools ?? [])}
      bind:value={uniId}
      onSelect={handleSelect}
    />
    {#if $unisQueryResults.isLoading}
      <Spinner />
    {/if}
  </div>

  {#if $unisQueryResults.data?.total && $unisQueryResults.data?.total > 10}
    <div class="pagination-wrapper">
      <Pagination bind:currentPage {perPage} />
    </div>
  {/if}
</div>

<style>
  .pagination-wrapper {
    display: flex;
    justify-content: center;
    margin-top: 20px;
  }

  .text-input-wrapper {
    margin-bottom: 20px;
  }

  .grid-wrapper {
    margin-bottom: 20px;
    position: relative;
    min-height: 420px;
  }
</style>
