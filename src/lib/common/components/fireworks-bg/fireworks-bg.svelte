<script lang="ts">
  import { onMount } from "svelte";
  import { animateParticles, animeInstance } from "./firewirks-bg.utils";

  export let width: number;
  export let height: number;
  export let numberOfParticles: number = 30;
  export let maxFireworks: number = 30;
  export let onFinish: () => void;

  let fireworksWereLaunched: number = 0;

  let canvasEl: HTMLCanvasElement;
  let ctx: CanvasRenderingContext2D | null;

  $: ctx = canvasEl?.getContext("2d") ?? null;

  const colors: string[] = [
    "#ebbacb",
    "#dda8d1",
    "#a6e5d6",
    "#fbb6e2",
    "#a2c6cd",
    "#a2a2e8",
    "#b2aeae",
    "#c4f4d0",
    "#c7d0e6",
    "#a3e4d7",
  ];

  function setCanvasSize(): void {
    if (ctx && canvasEl) {
      canvasEl.width = width * 2;
      canvasEl.height = height * 2;
      canvasEl.style.width = `${width}px`;
      canvasEl.style.height = `${height}px`;
      ctx.scale(2, 2);
    }
  }

  const centerX: number = width / 2;
  const centerY: number = height / 2;

  function fire(): void {
    if (ctx) {
      animateParticles({
        x: animeInstance.random(centerX - 500, centerX + 500),
        y: animeInstance.random(centerY - 500, centerY + 500),
        colors: colors,
        ctx: ctx,
        numberOfParticles: numberOfParticles,
      });

      animeInstance({ duration: 200 }).finished.then(() => {
        fireworksWereLaunched++;

        if (fireworksWereLaunched < maxFireworks) {
          fire();
        } else {
          if (onFinish) {
            setTimeout(() => {
              onFinish();
            }, 1000);
          }
        }
      });
    }
  }

  onMount(() => {
    setTimeout(() => {
      setCanvasSize();

      fire();

      animeInstance({
        duration: Infinity,
        update: () => {
          if (ctx && canvasEl) {
            ctx.clearRect(0, 0, canvasEl.width, canvasEl.height);
          }
        },
      });
    }, 0);

    window.addEventListener("resize", setCanvasSize, false);
  });
</script>

<canvas bind:this={canvasEl} class="fireworks"></canvas>

<style>
  .fireworks {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    pointer-events: none;
    overflow: hidden;
  }
</style>
