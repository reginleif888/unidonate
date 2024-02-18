<script lang="ts">
  import { fade } from "svelte/transition";
  import { Page } from "$lib/common/components";
  import {
    ExplorerTable,
    SearchDonationModal,
  } from "$lib/donation-explorer/components";

  let searchDonationModalOpen: boolean = false;

  const handleSearchDonationModalOpen = () => {
    searchDonationModalOpen = true;
  };
</script>

<Page>
  <div class="root" in:fade>
    <ExplorerTable onSearchDonation={handleSearchDonationModalOpen} />
  </div>
</Page>

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
