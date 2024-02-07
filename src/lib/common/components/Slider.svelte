<script lang="ts">
  import { Slider } from "bits-ui";
  import TextInput from "./TextInput.svelte";

  export let value: Array<number> = [25];

  export let onChange: (value: Array<number>) => void = () => null;

  function handleChange(newValue: Array<number>) {
    if (isNaN(newValue[0])) {
      onChange([0]);

      return;
    }

    if (value[0] === newValue[0]) {
      return;
    }

    onChange(newValue);
  }
</script>

<div class="slider-container">
  <div class="slider-label subtitle1">Label</div>
  <div class="inner">
    <Slider.Root
      step={1}
      {value}
      onValueChange={handleChange}
      let:thumbs
      class="slider-root"
    >
      <span class="slider-track">
        <Slider.Range class="slider-range" />
      </span>
      {#each thumbs as thumb}
        <Slider.Thumb {thumb} class="slider-thumb" />
      {/each}
    </Slider.Root>
    <div class="input-wrapper">
      <TextInput
        label="Percent"
        onChange={(value) => {
          handleChange([Number(String(value).replace("%", ""))]);
        }}
        value={String(value[0]).includes("%")
          ? String(value[0])
          : String(value[0]) + "%"}
        isPercent
      />
    </div>
  </div>
</div>

<style>
  .slider-label {
    margin-bottom: 12px;
  }

  .inner {
    display: flex;
    justify-content: center;
    flex-direction: column;
    align-items: center;
    gap: 4px;
    margin-bottom: 8px;
  }

  .input-wrapper {
    /* max-width: 58px; */
    width: 100%;
  }

  :global(.slider-container) {
    width: 100%;
    height: 90px;
    /* max-width: 280px; */
  }

  :global(.slider-root) {
    position: relative;
    display: flex;
    width: 100%;
    touch-action: none;
    user-select: none;
    align-items: center;
    margin-bottom: 16px;
  }

  :global(.slider-track) {
    position: relative;
    height: 2px;
    width: 100%;
    flex-grow: 1;
    overflow: hidden;
    border-radius: 9999px;
    background-color: var(--divider-color);
  }

  :global(.slider-range) {
    position: absolute;
    height: 100%;
    background-color: var(--brand-primary-color);
  }

  :global(.slider-thumb) {
    display: block;
    width: 27px;
    height: 27px;
    cursor: grab;
    border-radius: 9999px;
    border: 1px solid var(--divider-color);
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    transition: border-color 0.2s;
    background-color: var(--brand-primary-color);
  }

  :global(.slider-thumb:hover) {
    border-color: var(--brand-primary-color);
  }

  :global(.slider-thumb:focus-visible) {
    outline: none;
    box-shadow: 0 0 0 2px #edf2f7;
  }

  :global(.slider-thumb:active) {
    transform: scale(0.98);
  }

  :global(.slider-thumb:disabled) {
    pointer-events: none;
    opacity: 0.5;
  }
</style>
