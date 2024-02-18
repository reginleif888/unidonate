<script lang="ts">
  import {
    Table,
    type IColumn,
    Pagination,
    Select,
    Button,
  } from "$lib/common/components";
  import InputWithLabel from "$lib/common/components/input-with-label.svelte";
  import { PAGE_SIZES_SELECT_ITEMS } from "$lib/donate/constant";
  import { MagnifyingGlass } from "phosphor-svelte";

  let topControlsElement: HTMLElement | null = null;

  const generateUniqueId = (): string => {
    return "uuid-" + Math.random().toString(36).substr(2, 9);
  };

  const columns: IColumn[] = [
    {
      key: "id",
      label: "Donation transaction Id",
    },
    {
      key: "name",
      label: "Bitcoin transaction Id",
    },
    {
      key: "age",
      label: "Age",
      format: (value: string): string => `${value} years`,
    },
    {
      key: "country",
      label: "Country",
    },
    // {
    //   key: "country",
    //   label: "Country",
    // },
  ];

  const rows = [
    {
      id: "1d01a1a8-c7b8-4d46-9dd3-b9876549916f",
      name: "Allison Weeks DDS",
      age: "26",
      country: "Cape Verde",
    },
    {
      id: "d69a821a-f730-45ae-abff-2a7a13839b7d",
      name: "Vincent Smith",
      age: "36",
      country: "Lao People's Democratic Republic",
    },
    {
      id: "b98e887b-56ff-4d0c-b749-c408743498ce",
      name: "Aaron Hanson",
      age: "66",
      country: "Poland",
    },
    {
      id: "2e3ea2c2-6ddf-4a90-a26a-40156c456114",
      name: "Lisa Randolph",
      age: "36",
      country: "Croatia",
    },
    {
      id: "0c1de6d9-da84-42a1-97f5-a5670ec9d283",
      name: "Natasha Carlson",
      age: "42",
      country: "Haiti",
    },
    {
      id: "e0c5d0c5-3d0a-4be6-a9ce-e22cf7017fcc",
      name: "Jeremy Hamilton",
      age: "18",
      country: "Suriname",
    },
    {
      id: "bbf5c532-fa91-4cb3-80ef-7bded0ac49ea",
      name: "Benjamin Wilson",
      age: "37",
      country: "Mongolia",
    },
    {
      id: "013ff676-9a06-470b-bee3-1f7288fd58df",
      name: "Adam Steele",
      age: "60",
      country: "British Indian Ocean Territory (Chagos Archipelago)",
    },
    {
      id: "90545672-381a-41de-bb6f-8799e084b743",
      name: "Aaron Hoffman",
      age: "43",
      country: "Saint Helena",
    },
    {
      id: "470ae2a8-1529-447d-9907-769b5777c31b",
      name: "Curtis Chambers",
      age: "20",
      country: "United Arab Emirates",
    },
    {
      id: "67adedc5-9c26-42ff-8901-68fd6dccc802",
      name: "William Weber",
      age: "60",
      country: "New Zealand",
    },
    {
      id: "eeb1cd41-4bff-4b64-b06f-6ae1865cd826",
      name: "Jeremy Downs",
      age: "27",
      country: "Canada",
    },
    {
      id: "7da10ef3-0db2-4b99-9539-fcaf48654184",
      name: "Jason Martin",
      age: "62",
      country: "Malawi",
    },
    {
      id: "fc4ab914-25bc-4689-a82e-8ee93b9000c0",
      name: "Jennifer Avila",
      age: "70",
      country: "Burundi",
    },
    {
      id: "e7d973b3-38aa-468c-9e3b-2d2e71f6e97f",
      name: "Joanna Holland",
      age: "34",
      country: "Kiribati",
    },
    {
      id: "0e37cbda-1fcf-44be-a198-5c54eea8ffc2",
      name: "Peter Morris",
      age: "43",
      country: "Algeria",
    },
    {
      id: "4d3b640b-5ae1-4039-bba3-c860f592f9af",
      name: "Shannon Rodriguez",
      age: "50",
      country: "Mali",
    },
    {
      id: "7a997102-185a-4dda-a278-b760cfbd7e88",
      name: "Kyle Payne",
      age: "50",
      country: "Greenland",
    },
    {
      id: "d6778e9f-2cf4-4d49-aa20-31518f327b15",
      name: "Douglas Spencer",
      age: "59",
      country: "Italy",
    },
    {
      id: "431a55d5-e5a2-4c31-90ab-0e5e9d6aadd8",
      name: "Paul Lindsey",
      age: "20",
      country: "Somalia",
    },
  ];

  // 'status' : DonationStatus,
  // 'donationId' : string,
  // 'studentId' : [] | [string],
  // 'paymentAddress' : string,
  // 'schoolId' : string,
  // 'allocations' : Array<AllocationCategory>,
  // 'amount' : Satoshi,
  // 'transactionId' : [] | [string],
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
        <Select
          items={[
            {
              label: "Id",
              value: "id",
            },
            {
              label: "Name",
              value: "name",
            },
            {
              label: "Age",
              value: "age",
            },
            {
              label: "Country",
              value: "country",
            },
          ]}
        />
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
      {rows}
      stickyHead
      stickyTop={topControlsElement?.clientHeight}
    />
  </div>

  <div class="explorer-table__bottom-controls">
    <div class="explorer-table__bottom-controls-select">
      <InputWithLabel label="Per page">
        <Select items={PAGE_SIZES_SELECT_ITEMS} />
      </InputWithLabel>
    </div>

    <Pagination count={50} />
  </div>
</div>

<style lang="scss">
  .explorer-table {
    width: 100%;

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
  }
</style>
