<script lang="ts">
  import {
    type FormSchool,
    EntityType,
    type FormStudent,
    type PaginationFilter,
  } from "$lib/donate/types";
  import { Page, UniIcon, DesktopStepper, Only } from "$lib/common/components";
  import type { StepItem } from "$lib/common/types";
  import { DonationStep } from "$lib/donate/types";
  import * as Icons from "phosphor-svelte";
  import { EntityPage, DonationPage } from "$lib/donate/pages";
  import { goto } from "$app/navigation";
  import { AppRoute } from "$lib/common/routes";
  import { useSchools, useStudents } from "$lib/donate/queries";
  import { mapSchoolToForm, mapStudentToForm } from "$lib/donate/mappers";
  import { toBigInt } from "$lib/common/utils";

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

  let selectedSchool: FormSchool | null = null;

  let selectedStudent: FormStudent | null = null;

  function goToAllocation() {
    currentStep = DonationStep.DonationAllocation;
  }

  function goToStudent() {
    currentStep = DonationStep.Student;
  }

  function handleConfirm() {
    goto(AppRoute.ConfirmDonate);
  }

  function handleSchoolSelect() {
    selectedStudentId = null;
  }

  $: {
    if (selectedSchoolId) {
      selectedSchool = formSchools?.find(
        (school) => school.id === selectedSchoolId
      )!;
    } else {
      selectedSchool = null;
      selectedStudentId = null;
    }
  }

  $: {
    if (selectedStudentId) {
      selectedStudent = formStudents?.find(
        (student) => student.id === selectedStudentId
      )!;
    } else {
      selectedStudent = null;
    }
  }

  $: {
    steps = steps.map((step) => {
      if (step.value === DonationStep.School) {
        step.img = selectedSchool?.imgs[0] ?? "";
        step.useImgInsteadOfIcon = Boolean(selectedSchool?.imgs[0]);
      }

      if (step.value === DonationStep.Student) {
        step.disabled = !selectedSchoolId || !selectedSchool?.numberOfStudents;
        step.img = selectedStudent?.imgs[0];
        step.useImgInsteadOfIcon = Boolean(selectedStudent?.imgs[0]);
      }

      if (step.value === DonationStep.DonationAllocation) {
        step.disabled = !selectedSchoolId;
      }

      return step;
    });
  }

  let getSchoolsPayload: PaginationFilter = {
    search: "",
    page: 1,
    perPage: 10,
  };

  $: schoolsQuery = useSchools({
    page: toBigInt(Number(getSchoolsPayload.page - 1)),
    perPage: toBigInt(Number(getSchoolsPayload.perPage)),
    filters: {
      schoolName: getSchoolsPayload.search,
      active: true,
    },
    enabled: currentStep === DonationStep.School,
  });

  let formSchools: Array<FormSchool> = [];

  $: formSchools = ($schoolsQuery?.data?.schools || []).map(mapSchoolToForm);

  let getStudentsPayload: PaginationFilter = {
    search: "",
    page: 1,
    perPage: 10,
  };

  $: studentsQuery = useStudents({
    schoolId: selectedSchoolId!,
    page: toBigInt(getStudentsPayload.page - 1),
    perPage: toBigInt(Number(getStudentsPayload.perPage)),
    filters: {
      studentName: getStudentsPayload.search,
      active: true,
    },
    enabled: currentStep === DonationStep.Student,
  });

  let formStudents: Array<FormStudent> = [];

  $: formStudents = ($studentsQuery?.data?.students || []).map(
    mapStudentToForm
  );
</script>

<Page>
  <div class="inner">
    <Only from="desktop">
      <div class="stepper-wrapper">
        <DesktopStepper {steps} bind:current={currentStep} />
      </div>
    </Only>

    {#if currentStep === DonationStep.School}
      <EntityPage
        entityType={EntityType.School}
        data={formSchools}
        total={Number($schoolsQuery?.data?.total) || 0}
        loading={$schoolsQuery?.isLoading}
        bind:filter={getSchoolsPayload}
        bind:selected={selectedSchoolId}
        onDirectDonate={goToAllocation}
        onStudentSelect={goToStudent}
        onSelect={handleSchoolSelect}
        noStudents={!selectedSchool?.numberOfStudents}
      />
    {/if}

    {#if currentStep === DonationStep.Student}
      <EntityPage
        entityType={EntityType.Student}
        data={formStudents}
        total={Number($studentsQuery?.data?.total) || 0}
        loading={$studentsQuery?.isLoading}
        bind:filter={getStudentsPayload}
        bind:selected={selectedStudentId}
        onDirectDonate={goToAllocation}
        noStudents={!selectedSchool?.numberOfStudents}
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
