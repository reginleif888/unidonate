<script lang="ts">
  import CardGrid from "$lib/donate/components/CardGrid.svelte";
  import { schools } from "$lib/donate/mocks";
  import { mapSchoolsToGridItems } from "$lib/donate/utils";

  let value = "";
</script>

<svelte:head>
  <title>Vite + SvelteKit + Motoko</title>
</svelte:head>

<div>
  Hello World!

  <CardGrid items={mapSchoolsToGridItems(schools)} bind:value />
</div>
