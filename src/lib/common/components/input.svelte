<script lang="ts">
  import { getContext } from "svelte";
  import {
    INPUT_WITH_LABEL_CONTEXT_KEY,
    type InputWithLabelContextType,
  } from "../context";

  export let value: string = "";
  export let size: "small" | "medium" = "medium";
  export let error: boolean = false;

  let focused: boolean = false;

  function handleFocus() {
    focused = true;
  }

  function handleBlur() {
    focused = false;
  }

  const labelContext = getContext<InputWithLabelContextType>(
    INPUT_WITH_LABEL_CONTEXT_KEY
  );
</script>

<div
  class="root"
  class:root--focus={focused}
  class:root--hover={focused}
  class:root--disabled={$$restProps?.disabled}
  class:medium={size === "medium"}
  class:small={size === "small"}
  class:error
>
  <slot name="start-icon" />
  <input
    bind:value
    {...$$restProps}
    name={labelContext?.label || $$restProps.name}
    class:input-text-medium={size === "medium"}
    class:input-text-small={size === "small"}
    class:medium={size === "medium"}
    class:small={size === "small"}
    class:error
    on:focus={handleFocus}
    on:blur={handleBlur}
  />
  <slot name="end-icon" />
</div>

<style lang="scss">
  .root {
    display: flex;
    align-items: center;
    gap: 8px;
    background-color: var(--uni-input-bg);
    border-radius: var(--uni-radius-input);
    border: 1px solid;
    border-color: var(--uni-input-border);

    &.medium {
      padding: var(--uni-padding-input-medium);
      height: var(--uni-height-input-medium);
    }

    &.small {
      padding: var(--uni-padding-input-small);
      height: var(--uni-height-input-small);
    }

    &:hover {
      border-color: var(--uni-input-border-hover);
      color: var(--uni-input-color-hover);
      background-color: var(--uni-input-bg-hover);
    }

    &.error {
      border-color: var(--uni-input-border-error);
      color: var(--uni-input-color-error);
      background-color: var(--uni-input-bg-error);
    }

    &::placeholder {
      color: var(--uni-text-color-600);
    }

    &--focus {
      outline: 2px solid var(--uni-focus-outline);
      border-color: var(--uni-input-border);

      &.error {
        outline: 2px solid var(--uni-focus-outline);
        border-color: var(--uni-input-border);
      }
    }

    &--disabled {
      border-color: var(--uni-input-border-disabled);
      color: var(--uni-input-color-disabled);
      background-color: var(--uni-input-bg-disabled);

      &:hover {
        border-color: var(--uni-input-border-disabled);
        color: var(--uni-input-color-disabled);
        background-color: var(--uni-input-bg-disabled);
      }
    }
  }

  input {
    box-sizing: border-box;
    border-radius: var(--uni-radius-input);
    border: unset;
    width: 100%;
    color: var(--uni-input-color);
    background-color: var(--uni-input-bg);
    padding: 0px;
    height: 100%;

    &:disabled {
      border-color: var(--uni-input-border-disabled);
      color: var(--uni-input-color-disabled);
      background-color: var(--uni-input-bg-disabled);
    }

    &.error {
      color: var(--uni-input-color-error);
    }

    &::placeholder {
      color: var(--uni-text-color-600);
    }

    &:focus {
      outline: unset;
      border-color: unset;
    }
  }
</style>
