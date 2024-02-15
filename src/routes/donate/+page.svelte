<script lang="ts">
  import { type FormSchool, EntityType } from "$lib/donate/types";
  import { Page, UniIcon, DesktopStepper } from "$lib/common/components";
  import type { StepItem } from "$lib/common/types";
  import { SelectedModal } from "$lib/donate/components";
  import { DonationStep } from "$lib/donate/types";
  import * as Icons from "phosphor-svelte";
  import { students, schools } from "$lib/donate/mocks";
  import { EntityPage } from "$lib/donate/pages";

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

  let selectedSchool: FormSchool | null = null;

  function handleSelectedModalOpen() {
    selectedModalOpen = true;
  }

  function handleSelectedModalClose() {
    selectedModalOpen = false;
  }

  $: {
    if (selected) {
      selectedSchool = schools.find((school) => school.id === selected)!;
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

    {#if currentStep === DonationStep.School}
      <EntityPage
        entityType={EntityType.School}
        onSelectedModalOpen={handleSelectedModalOpen}
        data={schools}
      />
    {/if}

    {#if currentStep === DonationStep.Student}
      <EntityPage
        entityType={EntityType.Student}
        onSelectedModalOpen={handleSelectedModalOpen}
        data={students}
      />
    {/if}
  </div>
</Page>

{#if selectedSchool}
  <SelectedModal
    bind:open={selectedModalOpen}
    onClose={handleSelectedModalClose}
    school={selectedSchool}
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
</style>
