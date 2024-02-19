<script lang="ts">
  import type {
    DoughnutChartDataItem,
    UniqueIdentifier,
  } from "$lib/common/types.js";
  import { calculatePieSlices } from "./doughnut-chart.utils";

  export let data: Array<DoughnutChartDataItem> = [];

  export let width: number = 100;

  export let height: number = 100;

  export let hoveredSlice: UniqueIdentifier | null | SVGPathElement = null;

  let total = data.reduce((acc, { value }) => acc + value, 0);

  $: slices = calculatePieSlices(data, total);
</script>

<div class="doughnut-chart-root">
  <div class="doughnut-chart-root__legend-container">
    {#each data as { color, label, value, id }}
      <div
        class="doughnut-chart-root__legend-item body1"
        class:doughnut-chart-root__legend-item--opacity={hoveredSlice &&
          hoveredSlice !== id}
      >
        <div
          class="doughnut-chart-root__legend-color"
          style={`background-color: ${color};`}
        ></div>
        <p>{label}</p>
        <p>:</p>
        <p>{value}</p>
        <p class="body1">
          ({((value / total) * 100).toFixed(2) + "%"})
        </p>
      </div>
    {/each}
  </div>
  <svg
    width={`${width}px`}
    height={`${height}px`}
    viewBox={`0 0 100 100`}
    style="overflow: visible;"
  >
    <!-- svelte-ignore a11y-no-static-element-interactions -->
    <!-- svelte-ignore a11y-mouse-events-have-key-events -->
    {#each slices as { d, color, id }}
      <!-- svelte-ignore a11y-unknown-role -->
      <!-- svelte-ignore a11y-no-static-element-interactions -->
      <path
        {d}
        fill={color}
        on:mouseover={() => {
          hoveredSlice = id;
        }}
        on:mouseout={() => {
          hoveredSlice = null;
        }}
        style={`transform-origin: 50% 50%; transition: transform 0.3s ease; ${hoveredSlice === id ? "transform: scale(1.1);" : ""}; opacity: ${hoveredSlice && hoveredSlice !== id ? 0.5 : 1}`}
        class="pie"
      />
    {/each}
  </svg>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .doughnut-chart-root {
    display: flex;
    align-items: center;
    gap: 8px;
    overflow: hidden;

    &__legend-container {
      display: flex;
      flex-direction: column;
      gap: 4px;
      padding: 16px;
      background-color: var(--uni-bg);
      border-radius: 16px;
      box-shadow: var(--uni-shadow-paper);
    }

    &__legend-item {
      display: flex;
      align-items: center;
      gap: 4px;
      padding-bottom: 4px;
      transition: opacity var(--uni-transition-default);

      &--opacity {
        opacity: 0.5;
      }
    }

    &__legend-color {
      min-width: 10px;
      height: 10px;
      border-radius: 50%;
    }
  }
</style>