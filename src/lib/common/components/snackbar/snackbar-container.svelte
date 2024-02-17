<script>
  import { fly } from "svelte/transition";
</script>

<div transition:fly={{ x: 200, duration: 300, opacity: 0 }}>
  <slot />
</div>
