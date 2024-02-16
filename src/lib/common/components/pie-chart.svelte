<script lang="ts">
  import type { PicChartDataItem } from "../types";

  export let data: Array<PicChartDataItem> = [];

  export let width: number = 100;

  export let height: number = 100;

  let hoveredSlice: number | null | SVGPathElement = null;

  function polarToCartesian(
    centerX: number,
    centerY: number,
    radius: number,
    angleInDegrees: number
  ) {
    const angleInRadians = ((angleInDegrees - 90) * Math.PI) / 180.0;

    return {
      X: centerX + radius * Math.cos(angleInRadians),
      Y: centerY + radius * Math.sin(angleInRadians),
    };
  }

  let total = data.reduce((acc, { value }) => acc + value, 0);

  function calculatePieSlices(data: Array<PicChartDataItem>) {
    let startAngle = 0;
    const outerRadius = 40;
    const innerRadius = 20;

    return data.map(({ color, label, value }, index) => {
      const sliceAngle = (value / total) * 360;
      const endAngle = startAngle + sliceAngle;
      const largeArcFlag = sliceAngle > 180 ? 1 : 0;

      const { X: startX, Y: startY } = polarToCartesian(50, 50, 40, startAngle);
      const { X: endX, Y: endY } = polarToCartesian(50, 50, 40, endAngle);

      const { X: innerStartX, Y: innerStartY } = polarToCartesian(
        50,
        50,
        innerRadius,
        endAngle
      );
      const { X: innerEndX, Y: innerEndY } = polarToCartesian(
        50,
        50,
        innerRadius,
        startAngle
      );

      const labelPosition = polarToCartesian(
        50,
        50,
        30,
        startAngle + sliceAngle / 2
      );
      startAngle = endAngle;

      return {
        d: `M ${startX} ${startY} A ${outerRadius} ${outerRadius} 0 ${largeArcFlag} 1 ${endX} ${endY} L ${innerStartX} ${innerStartY} A ${innerRadius} ${innerRadius} 0 ${largeArcFlag} 0 ${innerEndX} ${innerEndY} z`,
        color,
        label,
        labelX: labelPosition.X,
        labelY: labelPosition.Y,
        id: index,
        percent: ((value / total) * 100).toFixed(2) + "%",
      };
    });
  }

  function getTextClassNameByScreen() {
    return "body1";
  }

  let textClass: string;

  $: {
    textClass = getTextClassNameByScreen();
  }

  $: slices = calculatePieSlices(data);
</script>

<div class="root">
  <div class="legend-container">
    {#each data as { color, label, value }}
      <div class="legend-item">
        <div class="legend-color" style={`background-color: ${color};`}></div>
        <p class={`label ${textClass}`}>{label}</p>
        <p class={`${textClass}`}>:</p>
        <p class={`body1 ${textClass}`}>{value}</p>
        <p class={`body1 ${textClass}`}>
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
        bind:this={hoveredSlice}
        on:mouseover={() => (hoveredSlice = id)}
        on:mouseout={() => (hoveredSlice = null)}
        style={`transform-origin: 50% 50%; transition: transform 0.3s ease; ${hoveredSlice === id ? "transform: scale(1.1);" : ""}`}
        class="pie"
      />
    {/each}
  </svg>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .label {
    // max-width: 50%;
  }

  .percent {
    font-size: 6px;
    font-weight: 400;
    pointer-events: none;
  }

  .root {
    display: flex;
    align-items: center;
    gap: 8px;
    overflow: hidden;
  }

  .legend-container {
    display: flex;
    flex-direction: column;
    gap: 4px;
    padding: 16px;
    background-color: var(--uni-bg);
    border-radius: 16px;
    box-shadow: var(--uni-shadow-paper);
  }

  .legend-item {
    display: flex;
    align-items: center;
    gap: 4px;
    padding-bottom: 4px;
  }

  .legend-color {
    min-width: 10px;
    height: 10px;
    border-radius: 50%;
  }
</style>
