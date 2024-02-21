<script lang="ts">
  import { setContext } from "svelte";
  import { INPUT_WITH_LABEL_CONTEXT_KEY } from "$lib/common/context";

  export let label: string = "";
  export let errorMessage: string = "";
  export let required: boolean = false;
  export let rowView: boolean = false;
  export let fullWidth: boolean = false;

  setContext(INPUT_WITH_LABEL_CONTEXT_KEY, { label });
</script>

<div class:row-view={rowView} class:full-width={fullWidth}>
  <label for={label} class="overline"
    >{label}
    {#if required}<span class="required">(required)</span>{/if}</label
  >
  <slot />

  {#if errorMessage}
    <span class="caption error-message">{errorMessage}</span>
  {/if}
</div>

<style>
  label {
    margin-bottom: 4px;
    display: block;
    padding-left: 8px;
    font-weight: bold;
  }

  .required {
    font-weight: normal;
  }

  .error-message {
    color: var(--uni-error-color);
    padding-left: 8px;
    height: 20px;
  }

  .row-view {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .full-width {
    width: 100%;
  }
</style>
