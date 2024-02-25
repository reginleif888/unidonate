<script lang="ts">
  import {
    Button,
    DoughnutChart,
    InlineNotification,
    Tooltip,
    Divider,
  } from "$lib/common/components";
  import {
    BtcInput,
    CategoryDonationCard,
    DonationModal,
  } from "$lib/donate/components";
  import {
    AllocationCategory,
    type DonationError,
    type DonationFormValues,
    type FormSchool,
    type FormStudent,
  } from "../types";
  import { DONATE_INITIAL_VALUES, MAP_ALLOCATION_CATEGORY } from "../constant";
  import { type DoughnutChartDataItem } from "$lib/common/types";
  import { createForm } from "felte";
  import { validateDonation } from "../utils";
  import { mapDonationFormValuesToCreateDonationPayload } from "../mappers";
  import { useCreateDonation } from "../queries/use-create-donation";
  import { goto } from "$app/navigation";
  import { AppRoute } from "$lib/common/routes";
  import { screenWidthStore } from "$lib/common/stores";
  import { SCREEN } from "$lib/common/constant";

  export let selectedSchool: FormSchool;
  export let selectedStudent: FormStudent | null = null;
  export let donationModalOpen: boolean = false;
  export let btcValue: string = "";
  export let notificationElement: HTMLDivElement | null = null;

  let currentCurrency: string = "BTC";
  let scrollRoot: HTMLElement;
  let headingRoot: HTMLElement;
  let hoveredSlice: AllocationCategory | null = null;
  let stickyTopControls: boolean = false;
  let error: DonationError | null = null;
  let submitted: boolean = false;
  let numberBtcValue: number = 0;
  let donutData: Array<DoughnutChartDataItem> = [
    {
      color:
        MAP_ALLOCATION_CATEGORY[AllocationCategory.DesignAndDevelopment].color,
      value: 25,
      label:
        MAP_ALLOCATION_CATEGORY[AllocationCategory.DesignAndDevelopment].label,
      id: AllocationCategory.DesignAndDevelopment,
    },
    {
      color: MAP_ALLOCATION_CATEGORY[AllocationCategory.TeacherSupport].color,
      value: 25,
      label: MAP_ALLOCATION_CATEGORY[AllocationCategory.TeacherSupport].label,
      id: AllocationCategory.TeacherSupport,
    },
    {
      color: MAP_ALLOCATION_CATEGORY[AllocationCategory.SchoolSupplies].color,
      value: 25,
      label: MAP_ALLOCATION_CATEGORY[AllocationCategory.SchoolSupplies].label,
      id: AllocationCategory.SchoolSupplies,
    },
    {
      color: MAP_ALLOCATION_CATEGORY[AllocationCategory.LunchAndSnacks].color,
      value: 25,
      label: MAP_ALLOCATION_CATEGORY[AllocationCategory.LunchAndSnacks].label,
      id: AllocationCategory.LunchAndSnacks,
    },
  ];

  const createDonation = useCreateDonation();

  const { handleSubmit, data } = createForm<DonationFormValues>({
    initialValues: DONATE_INITIAL_VALUES,
    onSubmit: async (values) => {
      submitted = true;

      if (error && error.client) {
        scrollRoot.scrollTo({
          top:
            (notificationElement?.offsetTop ?? 0) -
            (notificationElement?.clientHeight ?? 0),
          behavior: "smooth",
        });

        return;
      }

      try {
        const createDonationPayload =
          mapDonationFormValuesToCreateDonationPayload({
            satoshi: values.satoshi,
            categories: values.categories,
            schoolId: selectedSchool.id,
            studentId: selectedStudent?.id,
          });

        await $createDonation.mutateAsync(createDonationPayload);

        donationModalOpen = true;
      } catch (e) {
        error = {
          satoshi: false,
          client: false,
          message: "Something went wrong, pls try again later",
        };

        console.error(e);
      }
    },
  });

  function checkStickyTopControls() {
    if (scrollRoot) {
      const scrollTop = scrollRoot.scrollTop;

      stickyTopControls = scrollTop > headingRoot.clientHeight + 48;
    }
  }
  function handleCategoriesAllocationReset() {
    $data.categories = DONATE_INITIAL_VALUES["categories"];
  }

  $: {
    donutData = donutData.map((item) => {
      return {
        ...item,
        value: $data.categories[item.id],
      };
    });
  }

  $: error = validateDonation($data);
</script>

<div class="root" bind:this={scrollRoot} on:scroll={checkStickyTopControls}>
  <div class="inner">
    <div class="heading-section" bind:this={headingRoot}>
      <h4 class="h4 step-heading">Allocate donation</h4>
      <div class="body1 step-description">
        {#if selectedStudent}
          Allocate a donation for <b
            >{selectedStudent.firstName} {selectedStudent.lastName}</b
          >, a student at <b>{selectedSchool.name}</b>.
        {:else}
          Allocate a donation for <b>{selectedSchool.name}</b>.
        {/if}
      </div>
    </div>

    <div class="top-controls" class:top-controls--scrolling={stickyTopControls}>
      <div class="budget-wrapper">
        <BtcInput
          bind:currentCurrency
          bind:numberSatValue={$data.satoshi}
          bind:numberBtcValue
          bind:btcValue
          error={submitted && error?.satoshi}
        />
      </div>
    </div>

    {#if !submitted}
      <div class="notifications-wrapper" bind:this={notificationElement}>
        <InlineNotification
          title="Info"
          message="Percent sum of all categories should be equal to 100%"
          type="info"
        />
      </div>
    {/if}

    {#if submitted && error}
      <div class="notifications-wrapper">
        <InlineNotification
          title="Oops..."
          message={error?.message}
          type="error"
        />
      </div>
    {/if}

    {#if submitted && !error}
      <div class="notifications-wrapper">
        <InlineNotification
          title="Congratulations!"
          message="You allocated your donation correctly 🎉"
          type="success"
        />
      </div>
    {/if}

    <div class="categories-grid">
      {#each Object.keys(AllocationCategory) as category (category)}
        <div
          class="card-wrapper"
          class:card-wrapper--opacity={hoveredSlice &&
            hoveredSlice !== category}
          class:card-error={submitted && error?.biggestCategory === category}
        >
          <CategoryDonationCard
            label={MAP_ALLOCATION_CATEGORY[category].label}
            value={String($data.categories[category])}
            bind:numberValue={$data.categories[category]}
          />
        </div>
      {/each}
    </div>

    <Divider />

    <div class="chart-wrapper">
      <DoughnutChart
        width={240}
        height={240}
        data={donutData}
        bind:hoveredSlice
        direction={$screenWidthStore < SCREEN.desktop ? "column" : "row"}
        formatValue={(percent) =>
          "≈" +
          (
            (currentCurrency === "BTC" ? numberBtcValue : $data.satoshi ?? 0) *
            (percent / 100)
          )
            .toFixed(currentCurrency === "BTC" ? 8 : 0)
            .replace(currentCurrency === "BTC" ? /0+$/ : "", "") +
          " " +
          currentCurrency}
      />
    </div>
  </div>

  <div class="controls-section">
    <div class="controls-section-buttons">
      <div class="reset-button-wrapper">
        <Tooltip>
          <Button
            label="Reset allocation"
            contained
            variant="secondary"
            slot="trigger"
            on:click={handleCategoriesAllocationReset}
          />
          <div slot="content">Reset all categories to 25%</div>
        </Tooltip>
      </div>
      <Button
        label="Create donation"
        contained
        on:click={handleSubmit}
        loading={$createDonation.isLoading}
        notClickable={$createDonation.isLoading}
      />
    </div>
  </div>
</div>

<DonationModal
  transactionId={$createDonation.data?.donationId}
  btcAddress={$createDonation.data?.paymentAddress}
  total={btcValue}
  bind:open={donationModalOpen}
  onConfirm={() => {
    goto(
      `${AppRoute.ConfirmDonate}?donationId=${$createDonation.data?.donationId}`
    );
  }}
/>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  b {
    font-weight: 800;
  }

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
    padding: 8px;
    padding-bottom: 0px;

    @include respond-to("desktop") {
      padding: 16px;
    }
  }

  .step-heading {
    margin-bottom: 8px;
  }

  .step-description {
    margin-bottom: 8px;

    @include respond-to("desktop") {
      margin-bottom: 24px;
    }
  }

  .categories-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
    padding: 0 8px;
    margin-bottom: 12px;

    @include respond-to("desktop") {
      padding: 0 16px;
      margin-bottom: 24px;
    }
  }

  .top-controls {
    position: sticky;
    top: 0;
    margin-bottom: 12px;
    padding: 0 8px;
    transition: all var(--uni-transition-default);
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    z-index: 2;

    @include respond-to("desktop") {
      margin-bottom: 24px;
      padding: 0 16px;
    }

    &--scrolling {
      background-color: var(--uni-bg);
      box-shadow: var(--uni-shadow-paper);
      z-index: 2;
      padding: 8px;

      @include respond-to("desktop") {
        padding: 16px;
      }
    }
  }

  .budget-wrapper {
    max-width: 100%;
    width: 100%;

    @include respond-to("desktop") {
      max-width: 50%;
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
    align-items: center;
    padding: 0 8px;
    flex-grow: 1;

    @include respond-to("desktop") {
      padding: 0 16px;
    }
  }

  .controls-section {
    bottom: 0;
    position: sticky;
    background-color: var(--uni-bg);
    padding: 8px;
    border-top: 1px solid var(--uni-primary-transparent-70);
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    z-index: 2;

    @include respond-to("desktop") {
      padding: 16px;
      justify-content: flex-end;
    }
  }

  .controls-section-buttons {
    display: flex;
    gap: 16px;
    align-items: center;

    justify-content: space-between;
    width: 100%;

    @include respond-to("desktop") {
      justify-content: flex-end;
    }
  }

  .notifications-wrapper {
    width: 100%;
    display: flex;
    flex-direction: column;
    gap: 16px;
    margin-bottom: 8px;
    padding: 0 8px;

    @include respond-to("desktop") {
      margin-bottom: 16px;
      padding: 0 16px;
    }
  }

  .reset-button-wrapper {
    max-width: fit-content;
  }

  .card-error {
    outline: 2px solid var(--uni-error-color);
    border-radius: 16px;
  }
</style>
