<script lang="ts">
  import type { FormUni } from "$lib/donate/types.ts";
  import {
    Page,
    UniIcon,
    DesktopStepper,
    Button,
    Input,
    Modal,
    Pagination,
    InputWithLabel,
  } from "$lib/common/components";
  import type { StepItem } from "$lib/common/types";
  import { EntityGrid, SelectedModal, UniCard } from "$lib/donate/components";
  import { DonationStep } from "$lib/donate/types";
  import * as Icons from "phosphor-svelte";
  import { unis } from "$lib/donate/mocks";

  let steps: Array<StepItem> = [
    {
      label: "Select school",
      disabled: false,
      Icon: UniIcon,
      value: DonationStep.School,
    },
    {
      label: "Select student",
      disabled: false,
      Icon: Icons.Student,
      value: DonationStep.Student,
      optional: true,
    },
    {
      label: "Allocate budget",
      disabled: true,
      Icon: Icons.HandHeart,
      value: DonationStep.Budget,
    },
  ];

  let selected: string | null = null;

  let currentStep = DonationStep.School;

  let currentPage = 1;

  let search = "";

  let loading: boolean = false;

  let timerId: NodeJS.Timeout;

  let selectedModalOpen = false;

  let selectedUni: FormUni | null = null;

  function handleSelectedModalOpen() {
    selectedModalOpen = true;
  }

  function handleSelectedModalClose() {
    selectedModalOpen = false;
  }

  $: {
    if (selected) {
      selectedUni = unis.find((uni) => uni.id === selected)!;
    }
  }

  $: {
    let deps = [currentPage, search, currentStep];

    if (deps) {
      clearTimeout(timerId);

      loading = true;

      timerId = setTimeout(() => {
        loading = false;
      }, 1000);
    }
  }
</script>

<Page>
  <div class="inner">
    <div class="stepper-wrapper">
      <DesktopStepper {steps} bind:current={currentStep} />
    </div>
    <div class="form-content">
      <div class="main-section">
        <h4 class="h4 step-heading">Select school</h4>
        <div class="body1 step-description">
          Please select the school you would like to donate to.
        </div>
        <div class="search-wrapper">
          <InputWithLabel label="Search">
            <Input placeholder="School..." bind:value={search}>
              <span slot="end-icon">
                <Icons.MagnifyingGlass size={20} />
              </span>
            </Input>
          </InputWithLabel>
        </div>
        <div>
          <EntityGrid perPage={11} bind:selected {loading} />
        </div>
      </div>
      <div class="controls-section">
        <div>
          <Pagination count={50} bind:currentPage />
        </div>
        <Button
          label="Show selected"
          contained
          variant="primary"
          onClick={handleSelectedModalOpen}
        />
        <div
          class="controls-section-buttons"
          class:controls-section-buttons--selected={selected}
        >
          <Button label="Select student" contained variant="secondary" />
          <span class="body1">Or</span>
          <Button label="Donate directly to school" contained />
        </div>
      </div>
    </div>
  </div>
</Page>

{#if selectedUni}
  <SelectedModal
    bind:open={selectedModalOpen}
    onClose={handleSelectedModalClose}
    uni={selectedUni}
    student={null}
  />
{/if}

<style lang="scss">
  .stepper-wrapper {
    width: 340px;
    height: 100%;
  }

  .inner {
    display: flex;
    align-items: flex-start;
    height: 100%;
    margin-bottom: 0;
  }

  .form-content {
    display: flex;
    flex-direction: column;
    background-color: var(--uni-bg-transparent-700);
    box-shadow: var(--uni-shadow-paper);
    width: 100%;
    height: 100%;
    margin-left: 80px;
    overflow: scroll;
  }

  .step-heading {
    margin-bottom: 8px;
  }

  .step-description {
    margin-bottom: 24px;
  }

  .search-wrapper {
    margin-bottom: 24px;
    width: 400px;
  }

  .main-section {
    padding: 16px;
  }

  .controls-section {
    bottom: 0;
    position: sticky;
    background-color: var(--uni-bg);
    padding: 16px;
    border-top: 1px solid var(--uni-primary-transparent-70);
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .controls-section-buttons {
    display: flex;
    gap: 16px;
    align-items: center;
    opacity: 0;
    transition: all var(--uni-transition-default);
    &--selected {
      opacity: 1;
    }
  }
</style>
