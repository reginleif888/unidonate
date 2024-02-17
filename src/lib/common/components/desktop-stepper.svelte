<script lang="ts">
  import { fade } from "svelte/transition";
  import type { StepItem } from "../types";

  export let steps: Array<StepItem> = [];
  export let current: string = "";

  function handleStepChange(value: string) {
    if (steps.find((step) => step.value === value)?.disabled) {
      return;
    }

    current = value;
  }
</script>

<div class="root">
  {#each steps as { label, value, disabled, optional, Icon, img, useImgInsteadOfIcon }, index}
    <div
      class="step-item-wrapper h6"
      class:step-item-wrapper--disabled={disabled}
    >
      <div class="label-wrapper">
        <div>
          {label}
        </div>
        {#if optional}
          <span class="caption">(optional)</span>
        {/if}
      </div>
      <button
        class="step-icon"
        on:click={() => handleStepChange(value)}
        {disabled}
        class:step-icon--current={current === value}
      >
        {#if useImgInsteadOfIcon}
          <img
            src={img}
            alt={label}
            class="step-image"
            transition:fade={{ duration: 250 }}
          />
        {/if}

        {#if !useImgInsteadOfIcon}
          <span transition:fade={{ duration: 250 }}>
            <Icon size={40} />
          </span>
        {/if}
      </button>
    </div>
    {#if index !== steps.length - 1}
      <div class="vertical-line" />
    {/if}
  {/each}
</div>

<style lang="scss">
  .root {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-end;
    height: 100%;
    position: relative;
    padding: 80px 0px;
    padding-left: 24px;
    margin-right: 100px;

    &::after {
      content: "";
      position: absolute;
      width: 2px;
      height: 100%;
      background-color: var(--uni-secondary);
      right: -35px;
      top: 0px;
      z-index: -1;
      opacity: 0.5;
    }
  }

  .step-icon {
    min-width: 60px;
    height: 60px;
    border-radius: 50%;
    background-color: var(--uni-secondary);
    border: unset;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    color: var(--uni-on-secondary);
    cursor: pointer;
    transition: all var(--uni-transition-default);

    &:disabled {
      background-color: var(--uni-bg-transparent-300);
      color: var(--uni-on-bg);
      cursor: default;
    }

    &--current {
      background-color: var(--uni-step-active-bg);
      color: var(--uni-on-primary);
      position: relative;
    }

    &::after {
      content: "";
      position: absolute;
      width: 10px;
      height: 10px;
      background-color: var(--uni-primary);
      border-radius: 50%;
      top: 50%;
      transform: translateY(-50%);
      right: -43px;
      border: 4px solid var(--uni-bg-transparent-300);
    }

    &.step-icon--current {
      &::after {
        background-color: var(--uni-step-active-bg);
      }
    }
  }

  .step-image {
    width: 90%;
    height: 90%;
    object-fit: cover;
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    bottom: 0;
    border-radius: 50%;
  }

  .step-item-wrapper {
    display: flex;
    align-items: center;
    gap: 16px;
    min-width: fit-content;
    width: 100%;
    justify-content: space-between;
    color: var(--uni-on-primary);

    &--disabled {
      opacity: 0.5;
    }
  }

  .vertical-line {
    width: 100%;
    width: 60px;
    height: 100%;
    max-height: 300px;
    position: relative;
    opacity: 0.7;

    &::before {
      content: "";
      position: absolute;
      top: 0;
      bottom: 0;
      left: 50%;
      width: 2px;
      background-color: var(--uni-secondary);
    }
  }

  .label-wrapper {
    width: 100%;
    text-align: start;
  }
</style>
