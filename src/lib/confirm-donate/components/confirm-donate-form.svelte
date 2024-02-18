<script lang="ts">
  import { Button, Input, InputWithLabel } from "$lib/common/components";

  export let onConfirm: () => void = () => null;
</script>

<div class="root">
  <h1 class="h4">Confirm donation</h1>

  <p class="body1">
    To confirm the donation, the transaction must be processed. Sometimes this
    can take some time, and if you receive an error, please try again later.
  </p>

  <InputWithLabel required label="Donation transaction Id (DTI)">
    <Input placeholder="My DTI..." />
  </InputWithLabel>
  <InputWithLabel required label="Bitcoin transaction Id (TXID)">
    <Input placeholder="My TXID..." />
  </InputWithLabel>
  <Button label="Confirm" contained on:click={onConfirm} />
</div>

<style>
  .root {
    padding: 24px;
    background-color: var(--uni-bg-transparent-700);
    border-radius: 24px;
    display: flex;
    flex-direction: column;
    gap: 16px;
    width: 100%;
    max-width: 600px;
    z-index: 1;
  }
</style>
