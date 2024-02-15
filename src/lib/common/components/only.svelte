<script lang="ts">
  import { SCREEN } from "../constant";
  import { screenWidth } from "../stores";

  export let from: keyof typeof SCREEN | null = null;
  export let to: keyof typeof SCREEN | null = null;
</script>

{#if (from ? $screenWidth >= SCREEN[from] : true) && (to ? $screenWidth < SCREEN[to] : true)}
  <slot />
{/if}
