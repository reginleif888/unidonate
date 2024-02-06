<script lang="ts">
  import CopyButton from "./../lib/common/components/CopyButton.svelte";
  import BrandsBanner from "$lib/common/components/BrandsBanner.svelte";
  import Button from "$lib/common/components/Button.svelte";
  import ThemeSwitch from "$lib/common/components/ThemeSwitch.svelte";
</script>

<svelte:head>
  <title>Vite + SvelteKit + Motoko</title>
</svelte:head>

<div>
  Hello World!

  <ThemeSwitch />

  <Button label="Click me" variant="primary" />
  <Button label="Click me" variant="secondary" />
  <Button label="Click me" variant="primary" contained />
  <Button label="Click me" variant="secondary" contained />

  <CopyButton value="Hello, world!" />

  <BrandsBanner />
</div>
