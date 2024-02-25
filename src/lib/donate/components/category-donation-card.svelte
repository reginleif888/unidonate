<script lang="ts">
  import { Input, Slider } from "$lib/common/components";
  import { Percent } from "phosphor-svelte";

  export let label: string = "";
  export let value: string = "25";
  export let numberValue: number = 25;

  function handleInput(event: Event) {
    const target = event.target as HTMLInputElement;

    if (!target.value) {
      value = "0";
    }

    value = target.value;
  }
  function handleSlider(values: Array<number>) {
    value = String(values[0]);
  }

  $: {
    if (!value) {
      value = "0";
    }
  }

  $: {
    numberValue = Number(value);
  }
</script>

<div class="root">
  <h4 class="h6">{label}</h4>
  <div class="input-wrapper">
    <Input
      value={String(Number(value))}
      imaskOpts={{
        mask: Number,
        scale: 0,
        autofix: true,
        normalizeZeros: true,
        min: 0,
        max: 100,
      }}
      on:input={handleInput}
    >
      <span slot="end-icon"><Percent /></span>
    </Input>
  </div>
  <Slider value={[Number(value)]} onChange={handleSlider} />
</div>

<style>
  .root {
    background-color: var(--uni-bg);
    padding: 16px;
    display: flex;
    flex-direction: column;
    gap: 16px;
    border-radius: 16px;
    box-shadow: var(--uni-shadow-paper);
  }

  .input-wrapper {
    max-width: 200px;
  }
</style>
