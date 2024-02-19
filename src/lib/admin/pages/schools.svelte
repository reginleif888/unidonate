<script lang="ts">
  import { fade } from "svelte/transition";
  import { SchoolsTable } from "../components";
</script>

<div class="root" in:fade>
  <SchoolsTable />
</div>

<style>
  .root {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
  }
</style>
