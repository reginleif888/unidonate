<script lang="ts">
  import Button from "$lib/common/components/Button.svelte";
  import InlineNotification from "$lib/common/components/InlineNotification.svelte";
  import TextInput from "$lib/common/components/TextInput.svelte";
  import { useVerifyDonation } from "$lib/confirm-donate/queries/useVerifyDonation";
  import { onMount } from "svelte";

  let donateTransactionId: string = "";

  let bitcoinTransactionId: string = "";

  let isVerified = false;

  $: verifyDonation = useVerifyDonation({
    onVerify: () => {
      isVerified = true;

      setTimeout(() => {
        isVerified = false;
      }, 5000);
    },
  });

  onMount(() => {
    const params = new URLSearchParams(window.location.search);
    const param = params.get("donateTransactionId");

    donateTransactionId = param as string;

    if (param) {
      params.delete("donateTransactionId");
      window.history.pushState({}, "", `${window.location.pathname}`);
    }
  });
</script>

<section class="content">
  <div class="h1 title">Confirm donate</div>

  <InlineNotification
    type="info"
    title="Important!"
    message="In case if it does not work - try it later."
  />

  <TextInput
    label="Donation transaction ID (DTI)"
    placeholder="DTI"
    bind:value={donateTransactionId}
  />

  <TextInput
    label="Bitcoin transaction ID (TXID)"
    placeholder="TXID"
    bind:value={bitcoinTransactionId}
  />

  <Button
    label="Confirm"
    variant="secondary"
    contained
    onClick={() => {
      $verifyDonation.mutateAsync({
        donationId: donateTransactionId,
        transactionId: bitcoinTransactionId,
      });
    }}
  />

  {#if isVerified}
    <InlineNotification
      type="success"
      title="Done. ✅"
      message="Your payment was confirmed!"
    />
  {/if}
</section>

<style>
  .title {
    margin-bottom: 40px;
  }
  .content {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
  }
</style>
