<script lang="ts">
  import Button from "$lib/common/components/Button.svelte";
  import InlineNotification from "$lib/common/components/InlineNotification.svelte";
  import Slider from "$lib/common/components/Slider.svelte";
  import TextInput from "$lib/common/components/TextInput.svelte";
  import Tooltip from "$lib/common/components/Tooltip.svelte";
  import {
    ArrowCounterClockwise,
    HandHeart,
    CurrencyBtc,
  } from "phosphor-svelte";
  import { createForm } from "svelte-forms-lib";
  import { DONATE_INITIAL_VALUES } from "../constant";
  import type { DonationFormValues } from "../types";
  import Spinner from "$lib/common/components/Spinner.svelte";

  // mock async request
  const makeRequest = () => new Promise((resolve) => setTimeout(resolve, 1000));

  let submitting: boolean = false;

  const {
    // observables state
    form,
    errors,
    state,
    touched,
    isValid,
    isSubmitting,
    isValidating,
    // handlers
    updateField,
    handleReset,
    handleChange,
    handleSubmit,
  } = createForm<DonationFormValues>({
    initialValues: DONATE_INITIAL_VALUES,
    onSubmit: (values) => {
      submitting = true;
      console.log("values", values);

      return makeRequest().then(() => {
        alert(JSON.stringify(values, null, 2));

        submitting = false;
      });
    },
  });

  function handleTotalAmountChange(value: string) {
    const field = "totalAmount" as keyof DonationFormValues;

    updateField(field, value);
  }

  function handleCategoryValueChange(index: number, value: string) {
    const field = `categories[${index}].percent` as keyof DonationFormValues;

    updateField(field, value);
  }

  $: {
    console.log("form=====", $form.categories);
  }
</script>

<form on:submit={handleSubmit} class="root">
  <div class="top-section">
    <TextInput
      label="Amount in BTC"
      isBtc
      value={String($form.totalAmount)}
      on:change={() => {
        handleTotalAmountChange("0");
      }}
    >
      <svelte:fragment slot="start-icon">
        <CurrencyBtc size={24} />
      </svelte:fragment>
    </TextInput>
  </div>

  {#each $form.categories as category, index}
    <div class="slider-container">
      <Slider
        value={[Number($form.categories[index].percent)]}
        onChange={(value) => {
          handleCategoryValueChange(index, String(value[0]));
        }}
      />
    </div>
  {/each}

  <div class="inline-notification">
    <InlineNotification
      type="error"
      title="Ooops...💥"
      message="Seems like allocated budget is wrong. Please check it again."
    />
  </div>

  <div class="controls">
    <Tooltip>
      <slot slot="trigger">
        <Button
          label="Reset allocation"
          type="reset"
          variant="secondary"
          contained
        >
          <svelte:fragment slot="end-icon">
            <ArrowCounterClockwise size={24} />
          </svelte:fragment>
        </Button>
      </slot>
      <slot slot="content">Allocate all categories to 25%</slot>
    </Tooltip>

    <Button label="Donate" type="submit" variant="primary" contained>
      <svelte:fragment slot="end-icon">
        <HandHeart size={24} />
      </svelte:fragment>
    </Button>
  </div>

  {#if submitting}
    <Spinner />
  {/if}
</form>

<style>
  .root {
    position: relative;
  }
  .inline-notification {
    margin-bottom: 20px;
  }

  .top-section {
    margin-bottom: 40px;
  }
  .slider-container {
    display: flex;
    gap: 20px;
    margin-bottom: 40px;
    height: 160px;
    gap: 20px;
    border-bottom: 1px solid var(--divider-color);
    background-color: var(--info-bg);
    padding: 8px;
  }

  .controls {
    display: flex;
    justify-content: space-between;
    flex-direction: column;
    align-items: center;
    gap: 20px;
    margin-bottom: 20px;
  }
</style>
