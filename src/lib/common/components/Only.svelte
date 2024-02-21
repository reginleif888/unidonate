<script lang="ts">
  import { SCREEN } from "../constant";
  import { screenWidthStore } from "../stores";

  export let from: keyof typeof SCREEN | null = null;
  export let to: keyof typeof SCREEN | null = null;
</script>

{#if (from ? $screenWidthStore >= SCREEN[from] : true) && (to ? $screenWidthStore < SCREEN[to] : true)}
  <slot />
{/if}
