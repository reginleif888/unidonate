<script lang="ts">
  import { fade } from "svelte/transition";
  import { Page } from "$lib/common/components";
  import { ExplorerTable } from "$lib/donation-explorer/components";
</script>

<Page>
  <div class="root" in:fade>
    <ExplorerTable />
  </div>
</Page>

<style>
  .root {
    width: 100%;

    /* margin: 0 200px; */
    height: 100%;
    display: flex;
    flex-direction: column;
  }
</style>
