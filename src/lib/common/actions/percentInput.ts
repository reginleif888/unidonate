import { onMount } from "svelte";

type Options = {
  active?: boolean;
};

export function percentInput(node: HTMLElement, { active = true }: Options) {
  function format(value: string) {
    let num = parseFloat(value);

    if (!Number(value)) {
      return Number(0).toFixed(0);
    }

    if (isNaN(num)) {
      return Number(0).toFixed(0);
    }

    num = Math.max(num, 0);

    const selectionStart = (node as HTMLInputElement).selectionStart;

    if (selectionStart === 1 && String(num)[1] === "0") {
      num = Number(String(num).replace("0", ""));
    }

    num = Math.min(num, 100);

    num = Math.abs(num);

    num = Number(
      (node as HTMLInputElement).value.replace("%", "") === "0"
        ? Number(String(num).replace("0", ""))
        : num
    );

    return num.toFixed(0);
  }

  function update(event: any) {
    if (!active) {
      return;
    }

    const selectionStart = event.target.selectionStart;
    const selectionEnd = event.target.selectionEnd;
    const valueWithoutPercent = event.target.value.replace("%", "");
    const formattedValue = format(valueWithoutPercent);

    event.target.value = formattedValue + "%";

    event.target.setSelectionRange(selectionStart, selectionEnd);
  }

  function initialize() {
    const formattedValue = format(
      (node as HTMLInputElement).value.replace("%", "")
    );
    (node as HTMLInputElement).value = formattedValue + "%";
  }

  onMount(() => {
    initialize();
  });

  node.addEventListener("input", update);

  return {
    update(newOptions: Options) {
      active = newOptions.active !== undefined ? newOptions.active : active;
    },
    destroy() {
      node.removeEventListener("input", update);
    },
  };
}
