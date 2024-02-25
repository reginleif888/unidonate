<script lang="ts">
  import type { HTMLButtonAttributes } from "svelte/elements";
  import Spinner from "./spinner.svelte";

  type $$Props = HTMLButtonAttributes & {
    variant?: "primary" | "secondary";
    contained?: boolean;
    size?: "small" | "medium";
    label?: string;
    fullWidth?: boolean;
    justify?: "left" | "center" | "right" | "between";
    onlyIcon?: boolean;
    loading?: boolean;
    notClickable?: boolean;
  };

  export let variant: "primary" | "secondary" = "primary";
  export let contained: boolean = false;
  export let size: "small" | "medium" = "medium";
  export let label: string = "";
  export let fullWidth: boolean = false;
  export let justify: "left" | "center" | "right" | "between" = "between";
  export let onlyIcon: boolean = false;
  export let loading: boolean = false;
  export let notClickable: boolean = false;
</script>

<button
  class:contained
  class:primary={variant === "primary"}
  class:secondary={variant === "secondary"}
  class:small={size === "small"}
  class:medium={size === "medium"}
  class:button-text-medium={size === "medium"}
  class:button-text-small={size === "small"}
  class:full-width={fullWidth}
  class:justify-left={justify === "left"}
  class:justify-center={justify === "center"}
  class:justify-right={justify === "right"}
  class:justify-between={justify === "between"}
  class:only-icon={onlyIcon}
  class:not-clickable={notClickable}
  on:click
  {...$$restProps}
  ><slot name="start-icon" />{label}<slot name="end-icon" />
  {#if loading}
    <Spinner />
  {/if}
</button>

<style>
  button {
    box-sizing: border-box;
    border-radius: var(--uni-radius-button);
    padding: var(--uni-padding-button);
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 8px;
    box-shadow: var(--uni-shadow-button);
    pointer-events: all;
  }

  .only-icon.only-icon {
    padding: 8px;
  }

  .justify-left {
    justify-content: flex-start;
  }

  .justify-center {
    justify-content: center;
  }

  .justify-right {
    justify-content: flex-end;
  }

  .justify-between {
    justify-content: space-between;
  }

  .full-width {
    width: 100%;
  }

  button:focus {
    outline: 2px solid var(--uni-focus-outline);
  }

  .medium {
    padding: var(--uni-padding-button-medium);
    height: var(--uni-height-button-medium);
  }

  .small {
    padding: var(--uni-padding-button-small);
    height: var(--uni-height-button-small);
  }

  button:disabled {
    cursor: default;
    box-shadow: unset;
    pointer-events: none;
  }

  .primary {
    background: var(--uni-primary-outlined-button-default-bg);
    color: var(--uni-primary-outlined-button-default-color);
    border: 1px solid var(--uni-primary-outlined-button-default-border);
  }

  .primary:hover {
    background: var(--uni-primary-outlined-button-hover-bg);
    color: var(--uni-primary-outlined-button-hover-color);
    border: 1px solid var(--uni-primary-outlined-button-hover-border);
  }

  .primary:disabled {
    background: var(--uni-primary-outlined-button-disabled-bg);
    color: var(--uni-primary-outlined-button-disabled-color);
    border: 1px solid var(--uni-primary-outlined-button-disabled-border);
  }

  .primary.contained {
    background: var(--uni-primary-contained-button-default-bg);
    color: var(--uni-primary-contained-button-default-color);
    border: 1px solid var(--uni-primary-contained-button-default-border);
  }

  .primary.contained:hover {
    background: var(--uni-primary-contained-button-hover-bg);
    color: var(--uni-primary-contained-button-hover-color);
    border: 1px solid var(--uni-primary-contained-button-hover-border);
  }

  .primary.contained:disabled {
    background: var(--uni-primary-contained-button-disabled-bg);
    color: var(--uni-primary-contained-button-disabled-color);
    border: 1px solid var(--uni-primary-contained-button-disabled-border);
  }

  .secondary {
    background: var(--uni-secondary-outlined-button-default-bg);
    color: var(--uni-secondary-outlined-button-default-color);
    border: 1px solid var(--uni-secondary-outlined-button-default-border);
  }

  .secondary:hover {
    background: var(--uni-secondary-outlined-button-hover-bg);
    color: var(--uni-secondary-outlined-button-hover-color);
    border: 1px solid var(--uni-secondary-outlined-button-hover-border);
  }

  .secondary:disabled {
    background: var(--uni-secondary-outlined-button-disabled-bg);
    color: var(--uni-secondary-outlined-button-disabled-color);
    border: 1px solid var(--uni-secondary-outlined-button-disabled-border);
  }

  .secondary.contained {
    background: var(--uni-secondary-contained-button-default-bg);
    color: var(--uni-secondary-contained-button-default-color);
    border: 1px solid var(--uni-secondary-contained-button-default-border);
  }

  .secondary.contained:hover {
    background: var(--uni-secondary-contained-button-hover-bg);
    color: var(--uni-secondary-contained-button-hover-color);
    border: 1px solid var(--uni-secondary-contained-button-hover-border);
  }

  .secondary.contained:disabled {
    background: var(--uni-secondary-contained-button-disabled-bg);
    color: var(--uni-secondary-contained-button-disabled-color);
    border: 1px solid var(--uni-secondary-contained-button-disabled-border);
  }

  .not-clickable {
    pointer-events: none;
  }
</style>
