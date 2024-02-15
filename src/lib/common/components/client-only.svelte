<script>
  let isClient = false;

  if (typeof window !== "undefined") {
    isClient = true;
  }
</script>

{#if isClient}
  <slot />
{/if}
