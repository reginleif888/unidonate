<script lang="ts">
  import { imask } from "@imask/svelte";
  import { getContext } from "svelte";
  import {
    INPUT_WITH_LABEL_CONTEXT_KEY,
    type InputWithLabelContextType,
  } from "../context";
  import type { HTMLInputAttributes } from "svelte/elements";
  import { type FactoryArg } from "imask";

  type $$Props = Omit<HTMLInputAttributes, "size"> & {
    size?: "small" | "medium";
    error?: boolean;
    value?: string;
    inputMask?: any | null;
    imaskOpts?: FactoryArg;
    readonly?: boolean;
  };

  export let size: "small" | "medium" = "medium";
  export let error: boolean = false;
  export let value: string = "";
  export let imaskOpts: FactoryArg = null as unknown as FactoryArg;

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
    {...$$restProps}
    name={labelContext?.label || $$restProps.name}
    class:input-text-medium={size === "medium"}
    class:input-text-small={size === "small"}
    class:medium={size === "medium"}
    class:small={size === "small"}
    use:imask={imaskOpts}
    bind:value
    on:input
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
    width: 100%;
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

  input[type="number"]::-webkit-inner-spin-button,
  input[type="number"]::-webkit-outer-spin-button {
    -webkit-appearance: none;
    margin: 0;
  }
</style>
