<script lang="ts">
  import { fade } from "svelte/transition";
  import { Button, Divider } from "$lib/common/components";
  import AnimatedCheckmark from "./animated-checkmark.svelte";

  export let onConfirm: () => void = () => null;

  export let dti: string;
  export let txid: string;
  export let rootElement: HTMLDivElement | null = null;
</script>

<div class="root" bind:this={rootElement} in:fade>
  <AnimatedCheckmark />

  <h1 class="h4">Donation Successful</h1>

  <p class="body1">
    Your transaction has been successfully confirmed. Thank you for your
    generous donation!
  </p>

  <Divider />

  <div>
    <p class="body2">Donation transaction Id (DTI): {dti}</p>
    <p class="body2">Bitcoin transaction Id (TXID): {txid}</p>
  </div>

  <Button
    label="View donation"
    contained
    variant="secondary"
    on:click={onConfirm}
  />
</div>

<style>
  .root {
    padding: 24px;
    /* background-color: var(--uni-bg-transparent-700); */
    border-radius: 24px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    gap: 16px;
    width: 100%;
    max-width: fit-content;
    z-index: 1;
    color: var(--uni-on-primary);
  }
</style>
