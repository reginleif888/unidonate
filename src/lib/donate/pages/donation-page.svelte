<script lang="ts">
  import {
    Button,
    Input,
    DoughnutChart,
    InlineNotification,
    InputWithLabel,
    Tooltip,
  } from "$lib/common/components";
  import { CategoryDonationCard } from "$lib/donate/components";
  import { CurrencyBtc } from "phosphor-svelte";
  import { AllocationCategory } from "../types";
  import { MAP_ALLOCATION_CATEGORY } from "../constant";
  import { type DoughnutChartDataItem } from "$lib/common/types";

  let donutData: Array<DoughnutChartDataItem> = [
    {
      color:
        MAP_ALLOCATION_CATEGORY[AllocationCategory.DesignAndDevelopment].color,
      value: 0.0000011,
      label:
        MAP_ALLOCATION_CATEGORY[AllocationCategory.DesignAndDevelopment].label,
      id: AllocationCategory.DesignAndDevelopment,
    },
    {
      color: MAP_ALLOCATION_CATEGORY[AllocationCategory.TeacherSupport].color,
      value: 0.0000021,
      label: MAP_ALLOCATION_CATEGORY[AllocationCategory.TeacherSupport].label,
      id: AllocationCategory.TeacherSupport,
    },
    {
      color: MAP_ALLOCATION_CATEGORY[AllocationCategory.SchoolSupplies].color,
      value: 0.0000023,
      label: MAP_ALLOCATION_CATEGORY[AllocationCategory.SchoolSupplies].label,
      id: AllocationCategory.SchoolSupplies,
    },
    {
      color: MAP_ALLOCATION_CATEGORY[AllocationCategory.LunchAndSnacks].color,
      value: 0.0000024,
      label: MAP_ALLOCATION_CATEGORY[AllocationCategory.LunchAndSnacks].label,
      id: AllocationCategory.LunchAndSnacks,
    },
  ];

  let scrollRoot: HTMLElement;

  let headingRoot: HTMLElement;

  let hoveredSlice: AllocationCategory | null = null;

  let stickyTopControls: boolean = false;

  function checkStickyTopControls() {
    if (scrollRoot) {
      const scrollTop = scrollRoot.scrollTop;

      stickyTopControls = scrollTop > headingRoot.clientHeight + 48;
    }
  }
</script>

<div class="root" bind:this={scrollRoot} on:scroll={checkStickyTopControls}>
  <div class="inner">
    <div class="heading-section" bind:this={headingRoot}>
      <h4 class="h4 step-heading">Allocate budget</h4>
      <div class="body1 step-description">
        Allocate budget to a school or student
      </div>
    </div>

    <div
      class="budget-wrapper"
      class:budget-wrapper--scrolling={stickyTopControls}
    >
      <InputWithLabel label="Total (BTC)">
        <Input>
          <span slot="start-icon" class="btc-icon"
            ><CurrencyBtc weight="bold" /></span
          >
        </Input>
      </InputWithLabel>
    </div>

    <div class="notifications-wrapper">
      <InlineNotification
        title="Oops..."
        message="Something went wrong"
        type="error"
      />
    </div>

    <div class="categories-grid">
      {#each Object.keys(AllocationCategory) as category (category)}
        <div
          class="card-wrapper"
          class:card-wrapper--opacity={hoveredSlice &&
            hoveredSlice !== category}
        >
          <CategoryDonationCard
            label={MAP_ALLOCATION_CATEGORY[category].label}
          />
        </div>
      {/each}
    </div>

    <div class="chart-wrapper">
      <DoughnutChart
        width={240}
        height={240}
        data={donutData}
        bind:hoveredSlice
      />
    </div>
  </div>

  <div class="controls-section">
    <div class="controls-section-buttons">
      <div class="reset-button-wrapper">
        <Tooltip>
          <Button
            label="Reset categories allocation"
            contained
            variant="secondary"
            slot="trigger"
          />
          <div slot="content">Reset all categories to 25%</div>
        </Tooltip>
      </div>
      <Button label="Create donation" contained>
        <span slot="end-icon" class="h6">🎉</span>
      </Button>
    </div>
  </div>
</div>

<style lang="scss">
  .root {
    background-color: var(--uni-bg-transparent-700);
    box-shadow: var(--uni-shadow-paper);
    width: 100%;
    height: 100%;
    overflow: scroll;
    display: flex;
    flex-direction: column;
    position: relative;
  }

  .inner {
    display: flex;
    display: flex;
    flex-direction: column;
    width: 100%;
    flex-grow: 1;
  }

  .heading-section {
    padding: 16px;
    padding-bottom: 0px;
  }

  .step-heading {
    margin-bottom: 8px;
  }

  .step-description {
    margin-bottom: 24px;
  }

  .categories-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
    padding: 0 16px;
  }

  .budget-wrapper {
    margin-bottom: 16px;
    position: sticky;
    top: 0;
    padding: 0 16px;
    transition: all var(--uni-transition-default);

    &--scrolling {
      background-color: var(--uni-bg);
      box-shadow: var(--uni-shadow-paper);
      z-index: 2;
      padding: 16px;
    }
  }

  .card-wrapper {
    width: 100%;
    min-width: 300px;
    flex: 1 1 calc(25% - 15px);
    transition: opacity var(--uni-transition-default);

    &--opacity {
      opacity: 0.5;
    }
  }

  .chart-wrapper {
    display: flex;
    justify-content: center;
    padding: 0 16px;
  }

  .controls-section {
    bottom: 0;
    position: sticky;
    background-color: var(--uni-bg);
    padding: 16px;
    border-top: 1px solid var(--uni-primary-transparent-70);
    display: flex;
    justify-content: flex-end;
    align-items: flex-end;
    z-index: 2;
  }

  .controls-section-buttons {
    display: flex;
    gap: 16px;
    align-items: center;
    justify-content: flex-end;
    width: 100%;
  }

  .notifications-wrapper {
    margin-bottom: 16px;
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 16px;
    padding: 0 16px;
  }

  .reset-button-wrapper {
    max-width: fit-content;
  }

  .btc-icon {
    position: relative;
    top: 2px;
  }
</style>
