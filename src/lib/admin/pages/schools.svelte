<script lang="ts">
  import { fade } from "svelte/transition";
  import { SearchDonationModal } from "$lib/donation-explorer/components";
  import { SchoolsTable } from "../components";

  let searchDonationModalOpen: boolean = false;
</script>

<div class="root" in:fade>
  <SchoolsTable />
</div>

<style>
  .root {
    width: 100%;

    /* margin: 0 200px; */
    height: 100%;
    display: flex;
    flex-direction: column;
  }
</style>
