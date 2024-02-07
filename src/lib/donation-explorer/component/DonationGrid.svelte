<script lang="ts">
  import Pagination from "$lib/common/components/Pagination.svelte";
  import TextInput from "$lib/common/components/TextInput.svelte";
  import { MagnifyingGlass } from "phosphor-svelte";

  import Spinner from "$lib/common/components/Spinner.svelte";
  import { debounce } from "$lib/common/utils";
  import { useDonations } from "../queries/useDonations";
  import CardGrid from "$lib/donation-explorer/component/CardGrid.svelte";
  import { number } from "$lib/common/actions/number";

  export let uniId: string = "";

  let search = "";

  let perPage = 100;

  let currentPage = 1;

  $: donationsQueryResults = useDonations({
    // @ts-ignore
    page: currentPage - 1,
    // @ts-ignore
    perPage: perPage,
    filters: {
      donationId: search,
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
      label="Search donation id"
    >
      <svelte:fragment slot="end-icon">
        <MagnifyingGlass size={24} />
      </svelte:fragment>
    </TextInput>
  </div>
  <div class="grid-wrapper">
    <CardGrid
      donations={$donationsQueryResults.data?.donations ?? []}
      bind:value={uniId}
    />
    {#if $donationsQueryResults.isLoading}
      <Spinner />
    {/if}
  </div>

  <!-- {#if $donationsQueryResults.data?.total && $donationsQueryResults.data?.total > 10}
    <div class="pagination-wrapper">
      <Pagination bind:currentPage {perPage} />
    </div>
  {/if} -->
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
