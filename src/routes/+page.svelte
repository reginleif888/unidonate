<script lang="ts">
  import { createActor, canisterId, backend } from "../declarations/backend";
  import { onMount } from "svelte";

  console.log("=== -1");

  let actor = createActor(canisterId);

  onMount(async () => {
    console.log("=== 0");
    actor = createActor(canisterId);
    helloWorld();
  });

  const helloWorld = async () => {
    console.log("=== helloWorld 0");

    try { 
    const donations = await backend.getDonations({
      filters: {
        donationId: "",
      },
      page: BigInt(0),
      perPage: BigInt(10),
    });

    console.log("=== helloWorld", donations);
  } catch (e) {
    console.error(e)
  }
  };
</script>

<svelte:head>
  <title>Vite + SvelteKit + Motoko</title>
</svelte:head>

<div>Hello World!</div>
