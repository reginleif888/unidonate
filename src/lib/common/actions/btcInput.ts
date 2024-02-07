import { onMount } from "svelte";

type Options = {
  active?: boolean;
  max?: number;
  min?: number;
};

export function btcInput(
  node: HTMLElement,
  { active = true, max, min }: Options
) {
  function format(value: string) {
    let num = parseFloat(value);

    if (!Number(value)) {
      return Number(0).toFixed(8);
    }

    if (isNaN(num)) {
      return Number(0).toFixed(8);
    }

    if (typeof min === "number") {
      num = Math.max(num, min);
    }
    if (typeof max === "number") {
      num = Math.min(num, max);
    }

    num = Math.abs(num);
    return num.toFixed(8);
  }

  function update(event: any) {
    if (!active) {
      return;
    }

    const selectionStart = event.target.selectionStart;
    const selectionEnd = event.target.selectionEnd;
    const valueWithoutPercent = event.target.value;
    const formattedValue = format(valueWithoutPercent);

    event.target.value = formattedValue;

    event.target.setSelectionRange(selectionStart, selectionEnd);
  }

  function initialize() {
    const formattedValue = format((node as HTMLInputElement).value);
    (node as HTMLInputElement).value = formattedValue;
  }

  onMount(() => {
    initialize();
  });

  node.addEventListener("input", update);

  return {
    update(newOptions: Options) {
      active = newOptions.active !== undefined ? newOptions.active : active;
      max = newOptions.max !== undefined ? newOptions.max : max;
      min = newOptions.min !== undefined ? newOptions.min : min;
    },
    destroy() {
      node.removeEventListener("input", update);
    },
  };
}
