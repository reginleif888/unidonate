<script lang="ts">
  import { fade } from "svelte/transition";
  import { Page, FireworksBg } from "$lib/common/components";
  import {
    ConfirmDonateForm,
    ConfirmDonateSuccess,
  } from "$lib/verify-donation/components";
  import { goto } from "$app/navigation";
  import { AppRoute } from "$lib/common/routes";
  import { onMount } from "svelte";
  import { useVerifyDonation } from "$lib/verify-donation/queries";

  let outerEl: HTMLElement;

  let fireworks = false;

  let success: boolean;

  let donationId: string;

  let transactionId: string;

  let error: string = "";

  const verifyDonation = useVerifyDonation();

  async function handleConfirm() {
    try {
      await $verifyDonation.mutateAsync({
        donationId,
        transactionId,
      });

      fireworks = true;
      success = true;
    } catch (e) {
      error = "Donation was not verified. Please try again later.";

      console.error(e);
    }
  }

  function handleFireworksFinish() {
    fireworks = false;
  }

  function onViewDonation(donationId: string) {
    goto(AppRoute.Donation.replace("[donationId]", donationId));
  }

  onMount(() => {
    const params = new URLSearchParams(window.location.search);
    const param = params.get("donationId");

    donationId = param as string;

    if (param) {
      params.delete("donationId");
      window.history.pushState({}, "", `${window.location.pathname}`);
    }
  });
</script>

<Page>
  <div class="outer" bind:this={outerEl} in:fade>
    <div class="inner">
      <div class="form-wrapper">
        {#if !success}
          <ConfirmDonateForm
            bind:donationId
            bind:transactionId
            onConfirm={handleConfirm}
            bind:serverErrorMessage={error}
            loading={$verifyDonation.isLoading}
          />
        {/if}

        {#if success}
          <ConfirmDonateSuccess
            dti={donationId}
            txid={transactionId}
            onView={onViewDonation}
          />
        {/if}

        {#if outerEl && fireworks}
          <FireworksBg
            width={outerEl.getBoundingClientRect().width}
            height={outerEl.getBoundingClientRect().height}
            numberOfParticles={50}
            maxFireworks={15}
            onFinish={handleFireworksFinish}
          />
        {/if}
      </div>
    </div>
  </div>
</Page>

<style>
  .outer {
    height: 100%;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
  }

  .inner {
    overflow: auto;
    padding: 8px;
    width: 100%;
  }

  .form-wrapper {
    width: fit-content;
    margin: 0 auto;
  }
</style>
