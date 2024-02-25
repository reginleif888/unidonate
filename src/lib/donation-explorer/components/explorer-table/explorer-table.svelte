<script lang="ts">
  import { Table, Pagination, Select, Button } from "$lib/common/components";
  import InputWithLabel from "$lib/common/components/input-with-label.svelte";
  import {
    MAP_ALLOCATION_CATEGORY,
    PAGE_SIZES_SELECT_ITEMS,
  } from "$lib/donate/constant";
  import { MagnifyingGlass } from "phosphor-svelte";
  import { columns, orderByOptions } from "./explorer-table.constant";
  import { useDonations } from "$lib/donation-explorer/queries";
  import type {
    DonationsSorting,
    GetDonationsPayload,
  } from "../../../../declarations/backend/backend.did";
  import { debounce } from "$lib/common/utils";
  import { mapDonationToForm } from "$lib/donation-explorer/mappers";
  import { OrderByOption } from "$lib/donation-explorer/types";
  import type { SelectItem } from "$lib/common/types";

  export let onSearchDonation: () => void = () => null;

  let currentPage: number = 1;

  let perPage = PAGE_SIZES_SELECT_ITEMS[3];

  let orderBy: SelectItem = orderByOptions[0];

  function getSorting(orderByOption: OrderByOption): DonationsSorting {
    if (orderByOption === OrderByOption.VerifiedAtDesc) {
      return {
        field: {
          verifiedAt: null,
        },
        order: {
          descending: null,
        },
      };
    }

    if (orderByOption === OrderByOption.VerifiedAtAsc) {
      return {
        field: {
          verifiedAt: null,
        },
        order: {
          ascending: null,
        },
      };
    }

    if (orderByOption === OrderByOption.AmountDesc) {
      return {
        field: {
          amount: null,
        },
        order: {
          descending: null,
        },
      };
    }

    if (orderByOption === OrderByOption.AmountAsc) {
      return {
        field: {
          amount: null,
        },
        order: {
          ascending: null,
        },
      };
    }

    return {
      field: {
        verifiedAt: null,
      },
      order: {
        descending: null,
      },
    };
  }

  $: sorting = getSorting(orderBy.value as OrderByOption);

  let query: GetDonationsPayload = {
    sorting: [],
    page: (Number(currentPage) - 1) as unknown as bigint,
    perPage: Number(perPage.value) as unknown as bigint,
  };

  const [debounced] = debounce(() => {
    query = {
      sorting: [sorting],
      page: (Number(currentPage) - 1) as unknown as bigint,
      perPage: Number(perPage.value) as unknown as bigint,
    };
  }, 300);

  function handleResetPage() {
    currentPage = 1;
  }

  $: [currentPage, perPage, sorting], debounced();

  $: donationsQuery = useDonations(query);

  $: donations = ($donationsQuery.data?.donations ?? []).map(mapDonationToForm);
</script>

<div class="explorer-table">
  <div class="explorer-table__header">
    <h4 class="h4">Donation explorer</h4>
  </div>

  <div class="explorer-table__top-controls">
    <div class="explorer-table__top-controls-left">
      <div class="explorer-table__order-by-select">
        <InputWithLabel label="Order by">
          <Select items={orderByOptions} bind:selected={orderBy} />
        </InputWithLabel>
      </div>
      <Button label="Search for donation" on:click={onSearchDonation}>
        <div slot="start-icon" class="explorer-table__magnify-glass">
          <MagnifyingGlass size={20} />
        </div>
      </Button>
    </div>

    <div class="explorer-table__top-controls-right">
      <div class="explorer-table__allocation-legends body2">
        {#each Object.keys(MAP_ALLOCATION_CATEGORY) as categoryKey (categoryKey)}
          <div>
            {MAP_ALLOCATION_CATEGORY[categoryKey].text} - {MAP_ALLOCATION_CATEGORY[
              categoryKey
            ].emoji}
          </div>
        {/each}
      </div>
    </div>
  </div>

  <div class="explorer-table__table-wrapper">
    <Table {columns} rows={donations} stickyHead />
  </div>
</div>
<div class="explorer-table__bottom-controls">
  <div class="explorer-table__bottom-controls-select">
    <InputWithLabel label="Per page">
      <Select
        items={PAGE_SIZES_SELECT_ITEMS}
        bind:selected={perPage}
        on:change={handleResetPage}
      />
    </InputWithLabel>
  </div>

  {#if Number($donationsQuery.data?.total) > Number(perPage.value)}
    <Pagination
      count={Number($donationsQuery.data?.total)}
      bind:currentPage
      perPage={Number(perPage.value)}
    />
  {/if}
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
      padding: 16px;
      display: flex;
      flex-direction: column;
      gap: 8px;
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
      max-width: 260px;
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
