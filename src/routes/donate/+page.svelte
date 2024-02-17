<script lang="ts">
  import { fade } from "svelte/transition";
  import {
    type FormSchool,
    EntityType,
    type FormStudent,
  } from "$lib/donate/types";
  import { Page, UniIcon, DesktopStepper } from "$lib/common/components";
  import type { StepItem } from "$lib/common/types";
  import { DonationStep } from "$lib/donate/types";
  import * as Icons from "phosphor-svelte";
  import { students, schools } from "$lib/donate/mocks";
  import { EntityPage, DonationPage } from "$lib/donate/pages";

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
      label: "Allocate donation",
      disabled: true,
      Icon: Icons.HandHeart,
      value: DonationStep.DonationAllocation,
    },
  ];

  let selectedSchoolId: string | null = null;

  let selectedStudentId: string | null = null;

  let currentStep = DonationStep.School;

  let selectedModalOpen = false;

  let selectedSchool: FormSchool | null = null;

  let selectedStudent: FormStudent | null = null;

  $: {
    if (selectedSchoolId) {
      selectedSchool = schools.find(
        (school) => school.id === selectedSchoolId
      )!;
    } else {
      selectedSchool = null;
      selectedStudentId = null;
    }
  }

  $: {
    if (selectedStudentId) {
      selectedStudent = students.find(
        (student) => student.id === selectedStudentId
      )!;
    } else {
      selectedStudent = null;
    }
  }

  $: {
    steps = steps.map((step) => {
      if (step.value === DonationStep.School) {
        step.img = selectedSchool?.img;
        step.useImgInsteadOfIcon = Boolean(selectedSchool?.img);
      }

      if (step.value === DonationStep.Student) {
        step.disabled = !selectedSchoolId;
        step.img = selectedStudent?.img;
        step.useImgInsteadOfIcon = Boolean(selectedStudent?.img);
      }

      if (step.value === DonationStep.DonationAllocation) {
        step.disabled = !selectedSchoolId;
      }

      return step;
    });
  }
</script>

<Page>
  <div class="inner" transition:fade>
    <div class="stepper-wrapper">
      <DesktopStepper {steps} bind:current={currentStep} />
    </div>

    {#if currentStep === DonationStep.School}
      <EntityPage
        entityType={EntityType.School}
        data={schools}
        bind:selected={selectedSchoolId}
      />
    {/if}

    {#if currentStep === DonationStep.Student}
      <EntityPage
        entityType={EntityType.Student}
        data={students}
        bind:selected={selectedStudentId}
      />
    {/if}

    {#if currentStep === DonationStep.DonationAllocation && selectedSchool}
      <DonationPage {selectedSchool} {selectedStudent} />
    {/if}
  </div>
</Page>

<style lang="scss">
  .stepper-wrapper {
    max-width: 380px;
    width: 100%;
    height: 100%;
  }

  .inner {
    display: flex;
    align-items: flex-start;
    height: 100%;
    margin-bottom: 0;
  }
</style>
