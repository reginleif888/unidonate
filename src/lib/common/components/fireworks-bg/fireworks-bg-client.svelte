<script lang="ts">
  import { SvelteComponent, onMount } from "svelte";
  let ClientOnlyComponent: typeof SvelteComponent<any>;

  export let width: number;
  export let height: number;
  export let onFinish: () => void;
  export let numberOfParticles: number;
  export let maxFireworks: number;

  onMount(async () => {
    const module = await import("./fireworks-bg.svelte");
    ClientOnlyComponent = module.default;
  });
</script>

<svelte:component
  this={ClientOnlyComponent}
  {width}
  {height}
  {onFinish}
  {numberOfParticles}
  {maxFireworks}
/>
