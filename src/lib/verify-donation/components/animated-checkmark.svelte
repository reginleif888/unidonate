<script lang="ts">
  import { onMount } from "svelte";
  import anime from "animejs";

  let circle: SVGCircleElement | null = null;

  onMount(() => {
    anime
      .timeline({ loop: false })
      .add({
        targets: "#checkCircle circle",
        strokeDashoffset: [anime.setDashoffset, 0],
        easing: "easeInOutSine",
        duration: 1000,
        complete: () => {
          if (circle) {
            circle.style.strokeDasharray = "unset";
          }
        },
      })
      .add(
        {
          targets: "#checkCircle polyline",
          strokeDashoffset: [anime.setDashoffset, 0],
          easing: "easeInOutSine",
          duration: 1000,
        },
        0
      ).complete;
  });
</script>

<svg id="checkCircle" width="100" height="100" viewBox="0 0 24 24">
  <circle
    bind:this={circle}
    cx="12"
    cy="12"
    r="10"
    stroke="var(--uni-success-color)"
    stroke-width="2"
    fill="none"
    stroke-dasharray="unset"
  />
  <polyline
    points="8 12 11 15 16 10"
    stroke="var(--uni-success-color)"
    stroke-width="2"
    fill="none"
    stroke-linecap="round"
    stroke-linejoin="round"
  />
</svg>
