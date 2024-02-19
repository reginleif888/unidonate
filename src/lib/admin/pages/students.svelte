<script lang="ts">
  import { fade } from "svelte/transition";
  import { StudentsTable } from "../components";
</script>

<div class="root" in:fade>
  <StudentsTable />
</div>

<style>
  .root {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
  }
</style>
