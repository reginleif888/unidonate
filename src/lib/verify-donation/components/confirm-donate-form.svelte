<script lang="ts">
  import {
    Button,
    InlineNotification,
    Input,
    InputWithLabel,
  } from "$lib/common/components";

  export let onConfirm: () => void = () => null;
  export let loading: boolean = false;
  export let donationId: string;
  export let transactionId: string;
  export let serverErrorMessage: string = "";

  let submitted: boolean = false;

  function handleConfirm() {
    serverErrorMessage = "";

    submitted = true;

    if (!donationId || !transactionId) {
      return;
    }

    onConfirm();
  }
  function formPreventDefault(event: Event) {
    event.preventDefault();
  }
</script>

<form class="root" on:submit={formPreventDefault}>
  <h1 class="h4">Verify donation</h1>

  <p class="body1">
    To verify the donation, the transaction must be processed. Sometimes this
    can take some time, and if you receive an error, please try again later.
  </p>

  {#if serverErrorMessage}
    <InlineNotification
      title="Oops..."
      message={serverErrorMessage}
      type="error"
    />
  {/if}

  <InputWithLabel
    required
    label="Donation transaction Id (DTI)"
    errorMessage={submitted && !donationId
      ? "Donation transaction Id is required"
      : ""}
  >
    <Input
      placeholder="My DTI..."
      readonly={loading ? true : undefined}
      bind:value={donationId}
      error={submitted && !donationId}
    />
  </InputWithLabel>
  <InputWithLabel
    required
    label="Bitcoin transaction Id (TXID)"
    errorMessage={submitted && !donationId
      ? "Bitcoin transaction Id is required"
      : ""}
  >
    <Input
      placeholder="My TXID..."
      readonly={loading ? true : undefined}
      bind:value={transactionId}
      error={submitted && !transactionId}
    />
  </InputWithLabel>
  <Button
    label="Verify"
    contained
    on:click={handleConfirm}
    {loading}
    notClickable={loading}
  />
</form>

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
