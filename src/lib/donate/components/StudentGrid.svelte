<script lang="ts">
  import { mapStudentsToGridItems } from "../utils";
  import CardGrid from "./CardGrid.svelte";
  import Spinner from "$lib/common/components/Spinner.svelte";
  import { useStudents } from "../queries/useStudents";

  export let uniId: string = "";

  export let studentId: string = "";

  $: studentsQueryResults = useStudents(uniId);
</script>

<div class="root">
  <div class="grid-wrapper">
    <CardGrid
      items={mapStudentsToGridItems($studentsQueryResults.data ?? [])}
      value={studentId}
    />

    {#if $studentsQueryResults.isLoading}
      <Spinner />
    {/if}
  </div>
</div>

<style>
  .grid-wrapper {
    margin-bottom: 20px;
    position: relative;
    min-height: 420px;
  }
</style>
