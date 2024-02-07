<script lang="ts">
  import { goto } from "$app/navigation";
  import BrandsBanner from "$lib/common/components/BrandsBanner.svelte";
  import Button from "$lib/common/components/Button.svelte";
  import { HandHeart } from "phosphor-svelte";
</script>

<svelte:head>
  <title>Vite + SvelteKit + Motoko</title>
</svelte:head>

<div class="h1">Home</div>

<div class="banner-wrapper"><BrandsBanner /></div>

<section>
  <Button
    label="Donate"
    type="submit"
    variant="primary"
    contained
    onClick={() => {
      goto("/donate");
    }}
  >
    <svelte:fragment slot="end-icon">
      <HandHeart size={24} />
    </svelte:fragment>
  </Button>
</section>

<style>
  .banner-wrapper {
    margin-bottom: 20px;
  }
</style>
