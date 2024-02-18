<script lang="ts">
  import { fade } from "svelte/transition";
  import { Page } from "$lib/common/components";
  import { DonationInfo } from "$lib/donation-explorer/components";
</script>

<Page>
  <div class="outer" in:fade>
    <DonationInfo />
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
