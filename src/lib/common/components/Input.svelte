<script lang="ts">
  export let size: "small" | "medium" = "medium";
  export let error: boolean = false;
</script>

<input
  {...$$restProps}
  class:input-text-medium={size === "medium"}
  class:input-text-small={size === "small"}
  class:medium={size === "medium"}
  class:small={size === "small"}
  class:error
/>

<style>
  input {
    box-sizing: border-box;
    border-radius: var(--uni-radius-input);
    border: 1px solid;

    border-color: var(--uni-input-border);
    color: var(--uni-input-color);
    background-color: var(--uni-input-bg);
  }

  input:hover {
    border-color: var(--uni-input-border-hover);
    color: var(--uni-input-color-hover);
    background-color: var(--uni-input-bg-hover);
  }

  input:disabled {
    border-color: var(--uni-input-border-disabled);
    color: var(--uni-input-color-disabled);
    background-color: var(--uni-input-bg-disabled);
  }

  input.error {
    border-color: var(--uni-input-border-error);
    color: var(--uni-input-color-error);
    background-color: var(--uni-input-bg-error);
  }

  .medium {
    padding: var(--uni-padding-input-medium);
    height: var(--uni-height-input-medium);
  }

  .small {
    padding: var(--uni-padding-input-small);
    height: var(--uni-height-input-small);
  }

  input::placeholder {
    color: var(--uni-text-color-600);
  }

  input:focus {
    outline: 2px solid var(--uni-focus-outline);
    border-color: var(--uni-input-border);
  }
</style>
