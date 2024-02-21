<script lang="ts">
  import { Input, Slider } from "$lib/common/components";
  import { Percent } from "phosphor-svelte";

  export let label: string = "";
</script>

<div class="root">
  <h4 class="h6">{label}</h4>
  <div class="input-wrapper">
    <Input value="25">
      <span slot="end-icon"><Percent /></span>
    </Input>
  </div>
  <Slider />
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
