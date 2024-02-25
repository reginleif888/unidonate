<script lang="ts">
  import { Switch } from "bits-ui";
  import { createEventDispatcher } from "svelte";

  export let checked: boolean = false;

  const dispatch = createEventDispatcher();

  function handleChange() {
    dispatch("change");
  }
</script>

<Switch.Root
  id="marketing"
  class="custom-switch-root"
  bind:checked
  onCheckedChange={handleChange}
>
  <Switch.Thumb class="custom-switch-thumb" />
</Switch.Root>

<style>
  :global(.custom-switch-root) {
    display: inline-flex;
    height: 36px;
    min-height: 36px;
    width: 60px;
    flex-shrink: 0;
    cursor: pointer;
    align-items: center;
    border-radius: 9999px;
    background-color: var(--uni-secondary);
    padding: 3px;
    transition: background-color 0.2s;
    outline: none;
    border: unset;
  }

  :global(.custom-switch-root:focus-visible) {
    outline: none;
    box-shadow:
      0 0 0 2px var(--uni-secondary),
      0 0 0 4px var(--uni-secondary);
  }

  :global(.custom-switch-root:disabled) {
    cursor: not-allowed;
    opacity: 0.5;
  }

  :global(.custom-switch-root[data-state="checked"]) {
    background-color: var(--uni-primary);
  }

  :global(.custom-switch-root[data-state="unchecked"]) {
    background-color: var(--uni-secondary);
  }

  :global(.custom-switch-thumb) {
    pointer-events: none;
    display: block;
    width: 30px;
    height: 30px;
    flex-shrink: 0;
    border-radius: 9999px;
    background-color: var(--uni-bg);
    transition: transform 0.2s;
  }

  :global(.custom-switch-thumb[data-state="checked"]) {
    transform: translateX(24px);
  }

  :global(.custom-switch-thumb[data-state="unchecked"]) {
    transform: translateX(0);
    border: var(--uni-divider-color);
  }
</style>
