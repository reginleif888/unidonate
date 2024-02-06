<script lang="ts">
  import { WarningCircle } from "phosphor-svelte";

  export let value: string | undefined = "";
  export let error: boolean | string = false;
  export let label: string | undefined = undefined;
  export let placeholder: string | undefined = undefined;
  export let disabled: boolean | undefined = undefined;

  let focused: boolean;

  let invalid: boolean;
  let invalidText: string | undefined;

  function handleFocus() {
    focused = true;
  }

  function handleBlur() {
    focused = false;
  }

  $: {
    invalid = Boolean(error);
    invalidText = typeof error === "string" ? error : undefined;
  }
</script>

<div class="text-input-root">
  <fieldset class="text-input-root__fieldset">
    {#if label}
      <legend
        class="text-input-root__legend overline"
        class:text-input-root__legend--focused={focused}
        ><span>{label}</span></legend
      >
    {/if}

    <div
      class="text-input-root__input-container"
      class:text-input-root__input-container--focused={focused}
      class:text-input-root__input-container--error={invalid}
      class:text-input-root__input-container--disabled={disabled}
    >
      {#if $$slots["start-icon"]}
        <div
          class="text-input-root__start-icon-container"
          class:icon-focused={focused}
        >
          <slot name="start-icon" />
        </div>
      {/if}
      <input
        class="text-input-root__input body2"
        {disabled}
        {placeholder}
        {value}
        on:focus={handleFocus}
        on:blur={handleBlur}
      />
      {#if invalid}
        <div class="text-input-root__error-icon-container">
          <WarningCircle
            size={20}
            class="text-input-root__error-icon error-icon"
          />
        </div>
      {/if}

      {#if $$slots["end-icon"]}
        <div
          class="text-input-root__end-icon-container"
          class:icon-focused={focused}
        >
          <slot name="end-icon" />
        </div>
      {/if}
    </div>

    {#if invalidText}
      <p class="text-input-root__error-text caption">{invalidText}</p>
    {/if}
  </fieldset>
</div>

<style lang="scss">
  .text-input-root {
    width: 100%;
    &__fieldset {
      padding: 0;
      margin: 0;
    }

    &__legend {
      padding-left: var(--input-spacing);
      margin-bottom: 12px;
      transition: color var(--transition-default);
      &--focused {
        color: var(--brand-primary-color);
      }
    }

    &__input {
      width: 100%;
      height: 100%;
      line-height: 1.5;
      padding: var(--input-spacing) 0;
      border: unset;
      background-color: var(--primary-bg);
      color: var(--heading-color);
      &:focus {
        outline: none;
      }

      &:disabled {
        color: var(--input-text-disabled-color);
        background-color: unset;
      }

      &::placeholder {
        color: var(--input-placeholder-disabled-color);
      }
    }

    &__input-container {
      display: inline-flex;
      align-items: center;
      width: 100%;
      padding: 0 var(--input-spacing);
      border: 1px solid var(--divider-color);
      background-color: var(--primary-bg);
      border-radius: var(--input-border-radius);
      height: var(--input-height);
      transition:
        border-color var(--transition-default),
        box-shadow var(--transition-default);
      box-shadow: var(--shadow-mini);

      &--disabled {
        background-color: var(--disabled-bg);
      }

      &--error {
        border-color: var(--error-color);
      }

      &--focused {
        border-color: var(--brand-primary-color);
        box-shadow: var(--focus-shadow);
      }
    }

    &__error-icon-container {
      margin-left: var(--input-spacing);
      transition: opacity var(--transition-default);
    }

    &__error-text {
      margin-left: var(--input-spacing);
      color: var(--error-color);
    }

    &__start-icon-container {
      margin-right: var(--input-spacing);
    }

    &__end-icon-container {
      margin-left: var(--input-spacing);
    }
  }

  :global(.text-input-root__error-icon) {
    fill: var(--error-color);
    transition: opacity var(--transition-default);
  }
</style>
