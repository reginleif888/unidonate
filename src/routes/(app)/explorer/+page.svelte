<script lang="ts">
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
  <div class="root">
    <ExplorerTable onSearchDonation={handleSearchDonationModalOpen} />
  </div>
</Page>

<SearchDonationModal bind:open={searchDonationModalOpen} />

<style>
  .root {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
  }
</style>
