<script lang="ts">
  import { onDestroy, onMount } from "svelte";

  export let duration: number = 60;

  export let width: number = 30;

  export let height: number = 30;

  export let onFinished: () => void = () => null;

  let countdown: number = duration;

  let interval: NodeJS.Timeout;

  onMount(() => {
    interval = setInterval(() => {
      countdown -= 50;
      if (countdown <= 0) {
        clearInterval(interval);

        onFinished();
      }
    }, 50);
  });

  onDestroy(() => {
    clearInterval(interval);
  });
</script>

<svg viewBox="0 0 36 36" width={`${width}px`} height={`${height}px`}>
  <path
    d="M18 2.0845
        a 15.9155 15.9155 0 0 1 0 31.831
        a 15.9155 15.9155 0 0 1 0 -31.831"
    fill="none"
    stroke="#ddd"
    stroke-width="4"
    stroke-dasharray="100, 100"
  />
  <path
    class="progress"
    d="M18 2.0845
        a 15.9155 15.9155 0 0 1 0 31.831
        a 15.9155 15.9155 0 0 1 0 -31.831"
    fill="none"
    stroke="currentColor"
    stroke-width="4"
    stroke-dasharray={100 - (countdown / duration) * 100 + ", 100"}
  />
</svg>

<style lang="scss">
  .progress {
    transition: stroke-dasharray 0.05s;
  }
</style>
