<script lang="ts">
  import { Select } from "bits-ui";
  import { flyAndScale } from "$lib/common/transitions";
  import { Check, CaretUpDown } from "phosphor-svelte";
  import { type SelectItem } from "$lib/common/types";
  import { createEventDispatcher } from "svelte";

  export let items: Array<SelectItem> = [];
  export let multiple: boolean = false;
  export let selected: Array<SelectItem> | SelectItem = [];
  export let placeholder: string = "Select";
  export let size: "small" | "medium" = "medium";

  const dispatch = createEventDispatcher();

  function handleChange(value: Array<SelectItem> | SelectItem | undefined) {
    dispatch("change", { value });
  }
</script>

<Select.Root {items} bind:selected {multiple} onSelectedChange={handleChange}>
  <Select.Trigger
    class={`uni-custom-select__trigger 
    ${size === "medium" ? "uni-custom-select__trigger--medium" : ""} 
    ${size === "small" ? "uni-custom-select__trigger--small" : ""}
    body2`}
    aria-label="Select a theme"
  >
    <slot name="start-icon" />
    <Select.Value class="uni-custom-select__value" {placeholder} />
    <CaretUpDown class="uni-custom-select__caret-icon" />
  </Select.Trigger>
  <Select.Content
    class="uni-custom-select__content"
    transition={flyAndScale}
    sideOffset={8}
  >
    {#each items as item}
      <Select.Item
        class="uni-custom-select__item body2"
        value={item.value}
        label={item.label}
      >
        {item.label}
        <Select.ItemIndicator
          class="uni-custom-select__indicator"
          asChild={false}
        >
          <Check />
        </Select.ItemIndicator>
      </Select.Item>
    {/each}
  </Select.Content>
  <Select.Input name="favoriteFruit" />
</Select.Root>

<style>
  :global(.uni-custom-select__trigger) {
    display: inline-flex;
    align-items: center;
    background-color: var(--uni-input-bg);
    border-radius: var(--uni-radius-input);
    border: 1px solid;
    border-color: var(--uni-input-border);
    color: var(--uni-on-bg);
    transition: color 0.2s;
    cursor: pointer;
    width: 100%;
  }

  :global(.uni-custom-select__trigger--medium) {
    height: var(--uni-height-input-medium);
    padding: var(--uni-padding-input-medium);
  }

  :global(.uni-custom-select__trigger--small) {
    height: var(--uni-height-input-small);
    padding: var(--uni-padding-input-small);
  }

  :global(.uni-custom-select__trigger:focus-within) {
    outline: 2px solid var(--uni-focus-outline);
  }

  :global(.uni-custom-select__trigger:focus-visible) {
    outline: 2px solid var(--uni-focus-outline);
  }

  :global(.uni-custom-select__palette-icon) {
    margin-right: 9px;
    font-size: 24px;
    color: #9ca3af;
  }

  :global(.uni-custom-select__value) {
    color: var(__text-color-600);
  }

  :global(.uni-custom-select__caret-icon) {
    margin-left: auto;
    font-size: 24px;
    color: #9ca3af;
  }

  :global(.uni-custom-select__content) {
    width: fit-content;
    border-radius: 0.75rem;
    border: 1px solid var(--uni-input-border);
    background-color: var(--uni-bg);
    padding: 0.25rem 0.5rem;
    box-shadow: var(--uni-shadow-popover);
    outline: none;
    z-index: var(--uni-zIndex-popover);
    min-width: min-content;
  }

  :global(.uni-custom-select__item) {
    display: flex;
    height: 40px;
    width: 100%;
    min-width: min-content;
    user-select: none;
    align-items: center;
    border-radius: var(--uni-radius-input);
    padding: 8px;
    color: var(--uni-on-bg);
    font-size: 14px;
    outline: none;
    transition: all 75ms;
    cursor: pointer;
  }

  :global(.uni-custom-select__item[data-highlighted]) {
    background-color: var(--uni-primary-transparent-70);
    color: var(--uni-on-primary);
  }

  :global(.uni-custom-select__indicator) {
    margin-left: auto;
  }
</style>
