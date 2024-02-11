<script lang="ts">
  import { Slider } from "bits-ui";

  export let value: Array<number> = [25];

  export let label: string = "Label";
</script>

<div class="slider-container">
  <div class="slider-label subtitle1">{label}</div>
  <div class="inner">
    <Slider.Root step={1} {value} let:thumbs class="slider-root">
      <span class="slider-track">
        <Slider.Range class="slider-range" />
      </span>
      {#each thumbs as thumb}
        <Slider.Thumb {thumb} class="slider-thumb" />
      {/each}
    </Slider.Root>
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

  :global(.slider-container) {
    width: 100%;
    height: 90px;
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
    background-color: grey;
  }

  :global(.slider-range) {
    position: absolute;
    height: 100%;
    background-color: red;
  }

  :global(.slider-thumb) {
    display: block;
    width: 27px;
    height: 27px;
    cursor: grab;
    border-radius: 9999px;
    border: 1px solid grey;
    box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    transition: border-color 0.2s;
    background-color: red;
  }

  :global(.slider-thumb:hover) {
    border-color: red;
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
