<script lang="ts">
  import { goto } from "$app/navigation";
  import { AppRoute } from "$lib/common/routes";
  import type { FormDonation } from "$lib/donation-explorer/types";
  import { ArrowSquareOut } from "phosphor-svelte";

  export let origin: FormDonation;

  const goToDonation = () => {
    goto(AppRoute.Donation.replace("[donationId]", origin.id));
  };
</script>

<div>
  <button on:click={goToDonation}>
    <ArrowSquareOut size={32} />
  </button>
</div>

<style lang="scss">
  button {
    background-color: transparent;
    border: none;
    cursor: pointer;
    padding: 0;
    position: relative;
    top: -4px;
    color: var(--uni-on-bg);

    &:hover {
      color: var(--uni-primary);
    }
  }
</style>
