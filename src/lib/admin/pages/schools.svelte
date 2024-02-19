<script lang="ts">
  import { fade } from "svelte/transition";
  import { SearchDonationModal } from "$lib/donation-explorer/components";

  let searchDonationModalOpen: boolean = false;
</script>

<div class="root" in:fade>Schools</div>

<SearchDonationModal bind:open={searchDonationModalOpen} />

<style>
  .root {
    width: 100%;

    /* margin: 0 200px; */
    height: 100%;
    display: flex;
    flex-direction: column;
  }
</style>
