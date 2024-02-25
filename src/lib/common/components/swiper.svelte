<script lang="ts" generics="T">
  import { onMount } from "svelte";
  import { CaretRight, CaretLeft } from "phosphor-svelte";

  export let items: Array<T> = [];

  let currentIndex: number = 0;
  let container: HTMLElement;

  function swipeRight(): void {
    currentIndex = currentIndex < items.length - 1 ? currentIndex + 1 : 0;
  }

  function swipeLeft(): void {
    currentIndex = currentIndex > 0 ? currentIndex - 1 : items.length - 1;
  }

  onMount(() => {
    let startX: number = 0;
    let endX: number = 0;
    const handleTouchStart = (e: TouchEvent) => {
      startX = e.touches[0].clientX;
    };
    const handleTouchMove = (e: TouchEvent) => {
      endX = e.touches[0].clientX;
    };
    const handleTouchEnd = () => {
      if (startX - endX > 50) swipeRight();
      else if (startX - endX < -50) swipeLeft();
    };
    container.addEventListener("touchstart", handleTouchStart);
    container.addEventListener("touchmove", handleTouchMove);
    container.addEventListener("touchend", handleTouchEnd);

    return () => {
      container.removeEventListener("touchstart", handleTouchStart);
      container.removeEventListener("touchmove", handleTouchMove);
      container.removeEventListener("touchend", handleTouchEnd);
    };
  });
</script>

<div class="root">
  <div bind:this={container} class="swiper-container">
    {#each items as item, index (index)}
      <div
        class="swiper-item"
        style="transform: translateX(-{currentIndex * 100}%);"
      >
        <slot {item} {index} />
      </div>
    {/each}
  </div>

  {#if items.length > 1}
    <button class="arrow left-arrow" on:click={swipeLeft}>
      <CaretLeft size={28} />
    </button>
    <button class="arrow right-arrow" on:click={swipeRight}
      ><CaretRight size={28} />
    </button>
  {/if}
</div>

<style>
  .root {
    width: 100%;
    height: 100%;
    position: relative;
  }

  .swiper-container {
    display: flex;
    overflow: hidden;
    position: relative;
  }
  .swiper-item {
    min-width: 100%;
    transition: transform 0.5s ease;
  }

  .arrow {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    color: var(--uni-on-secondary);
    background-color: var(--uni-secondary);
    border: none;
    cursor: pointer;
    display: flex;
    padding: 0px;
    border-radius: 4px;
  }
  .left-arrow {
    left: -14px;
  }
  .right-arrow {
    right: -14px;
  }
</style>
