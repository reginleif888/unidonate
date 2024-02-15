<script lang="ts">
  import { Page, UniIcon, DesktopStepper } from "$lib/common/components";
  import type { StepItem } from "$lib/common/types";
  import * as Icons from "phosphor-svelte";

  let steps: Array<StepItem> = [
    {
      label: "Select school",
      disabled: false,
      Icon: UniIcon,
      value: "school",
    },
    {
      label: "Select student",
      disabled: false,
      Icon: Icons.Student,
      value: "student",
      optional: true,
    },
    {
      label: "Allocate budget",
      disabled: true,
      Icon: Icons.HandHeart,
      value: "budget",
    },
  ];
</script>

<Page>
  <div class="inner">
    <div class="stepper-wrapper">
      <DesktopStepper {steps} current={"student"} />
    </div>
    <div class="form-content"></div>
  </div>
</Page>

<style>
  .stepper-wrapper {
    width: 340px;
    height: 100%;
  }

  .inner {
    display: flex;
    align-items: flex-start;
    height: 100%;
  }

  .form-content {
    display: flex;
    background-color: var(--uni-bg-transparent-700);
    box-shadow: var(--uni-shadow-paper);
    width: 100%;
    height: 100%;
    margin-left: 80px;
  }
</style>
