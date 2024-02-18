<script lang="ts">
  import { onMount } from "svelte";
  import anime from "animejs";

  export let unlocked: boolean = true;
  export let width: number = 150;
  export let height: number = 150;

  let shackleElement: SVGPathElement;
  let lineElement: SVGLineElement;
  let mounted = false;

  function playAnimation() {
    if (!mounted) {
      return;
    }

    const pathLength = shackleElement.getTotalLength();
    const partialLength = pathLength * 0.35;

    const animateShackle = (el: SVGPathElement) =>
      anime.setDashoffset(el) < partialLength
        ? anime.setDashoffset(el)
        : partialLength;

    const getOffsetTarget = (offset: Array<any>) =>
      unlocked ? offset : offset.reverse();

    anime
      .timeline()
      .add({
        targets: shackleElement,
        strokeDashoffset: getOffsetTarget([0, animateShackle]),
        easing: "easeInOutSine",
        duration: 1000,
        direction: "alternate",
        loop: false,

        autoplay: true,
      })
      .add(
        {
          targets: lineElement,
          strokeDashoffset: getOffsetTarget([0, anime.setDashoffset]),
          easing: "easeInOutSine",
          duration: 1000,
          direction: "alternate",
          loop: false,
          autoplay: true,
        },
        0
      );
  }

  onMount(() => {
    mounted = true;
  });

  $: {
    if (unlocked || !unlocked) {
      playAnimation();
    }
  }
</script>

<svg
  width={`${width}px`}
  height={`${height}px`}
  xmlns="http://www.w3.org/2000/svg"
  viewBox="0 0 256 256"
  color={unlocked ? "var(--uni-success-color)" : "currentColor"}
>
  <rect width="256" height="256" fill="none" />
  <circle
    cx="128"
    cy="140"
    r="20"
    fill="none"
    stroke="currentColor"
    stroke-linecap="round"
    stroke-linejoin="round"
    stroke-width="16"
  />
  <line
    x1="128"
    y1="160"
    x2="128"
    y2="184"
    fill="none"
    stroke="currentColor"
    stroke-linecap="round"
    stroke-linejoin="round"
    stroke-width="16"
    bind:this={lineElement}
  />
  <rect
    x="40"
    y="88"
    width="176"
    height="128"
    rx="8"
    fill="none"
    stroke="currentColor"
    stroke-linecap="round"
    stroke-linejoin="round"
    stroke-width="16"
  />
  <path
    d="M88,88V56a40,40,0,0,1,80,0V88"
    fill="none"
    stroke="currentColor"
    stroke-linecap="round"
    stroke-linejoin="round"
    stroke-width="16"
    bind:this={shackleElement}
  />
</svg>

<style>
  svg {
    transition: color 0.5s ease-in-out;
  }
</style>
