import { cubicOut } from "svelte/easing";

export function flyAndScale(
  node: Element,
  {
    delay = 0,
    duration = 150,
    easing = cubicOut,
    x = 0,
    y = 0,
    opacity = 0,
    startScale = 0,
    endScale = 1,
  } = {}
) {
  const style = getComputedStyle(node);
  const opacityInitial = Number(style.opacity);
  const transformInitial = style.transform === "none" ? "" : style.transform;

  return {
    delay,
    duration,
    easing,
    css: (t: number) => `
            transform: ${transformInitial} translate(${(1 - t) * x}px, ${(1 - t) * y}px) scale(${startScale + (endScale - startScale) * t});
            opacity: ${opacityInitial * t + opacity * (1 - t)};
        `,
  };
}
