import type { DoughnutChartDataItem } from "$lib/common/types";

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

export function calculatePieSlices(
  data: Array<DoughnutChartDataItem>,
  total: number
) {
  let startAngle = 0;
  const outerRadius = 40;
  const innerRadius = 14;

  return data.map(({ color, label, value, id }) => {
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
      id: id,
      percent: ((value / total) * 100).toFixed(2) + "%",
    };
  });
}
