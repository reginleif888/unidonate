<script lang="ts">
  import { Page } from "$lib/common/components";
  import { ExplorerTable } from "$lib/donation-explorer/components";
</script>

<Page>
  <div class="root">
    <ExplorerTable />
  </div>
</Page>

<style>
  .root {
    max-width: 1200px;
    margin: 0 auto;
    background-color: var(--uni-bg-transparent-700);
  }
</style>
