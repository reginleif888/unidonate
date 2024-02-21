<script lang="ts">
  import { fade } from "svelte/transition";
  import { Page, FireworksBg } from "$lib/common/components";
  import {
    ConfirmDonateForm,
    ConfirmDonateSuccess,
  } from "$lib/confirm-donate/components";
  import { goto } from "$app/navigation";
  import { AppRoute } from "$lib/common/routes";

  let outerEl: HTMLElement;

  let fireworks = false;

  let success: boolean;

  function handleConfirm() {
    fireworks = true;
    success = true;
  }

  function handleFireworksFinish() {
    fireworks = false;
  }

  function onViewDonation(donationId: string) {
    goto(AppRoute.Donation.replace("[donationId]", donationId));
  }
</script>

<Page>
  <div class="outer" bind:this={outerEl} in:fade>
    {#if !success}
      <ConfirmDonateForm onConfirm={handleConfirm} />
    {/if}

    {#if success}
      <ConfirmDonateSuccess
        txid="26773abc30f245ffee9cfc5f207e4766da31274e0ee1603ba5658a893dc18747"
        dti="26773abc30f245ffee9cfc5f207e4766da31274e0ee1603ba5658a893dc18747"
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
</Page>

<style>
  .outer {
    height: 100%;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    position: relative;
  }
</style>
