<script lang="ts">
  import type { GridItem } from "$lib/donate/types";
  import type { Donation } from "../../../declarations/backend/backend.did";
  import Card from "./Card.svelte";

  export let value: string | null = null;
  export let donations: Array<Donation> = [];

  const handleSelect = (donation: Donation) => {
    // if (donation.donationId === value) {
    //   value = "";
    //   onSelect("");
    //   return;
    // }
    // value = donation.donationId;
    // onSelect(donation.donation);
  };
</script>

<div class="root">
  {#each donations as donation (donation.donationId)}
    <Card {donation} />
  {/each}
</div>

<style>
  .root {
    display: grid;
    gap: 20px;
    grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
  }
</style>
