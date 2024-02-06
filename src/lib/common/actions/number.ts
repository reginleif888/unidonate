export type Options = {
  value: string | undefined;
  active: boolean;
  disableNegative?: boolean;
  min?: number;
  max?: number;
  minDecimalPlaces?: number;
  maxDecimalPlaces?: number;
};

export function number(
  node: HTMLElement,
  {
    value,
    active,
    disableNegative,
    min,
    max,
    minDecimalPlaces,
    maxDecimalPlaces,
  }: Options
) {
  const formatter = new Intl.NumberFormat("en-US", {
    minimumFractionDigits: minDecimalPlaces,
    maximumFractionDigits: maxDecimalPlaces,
  });

  const processValue = (inputValue: string | number) => {
    let num = Number(inputValue);
    if (disableNegative) {
      num = Math.abs(num);
    }
    if (typeof min === "number") {
      num = Math.max(num, min);
    }
    if (typeof max === "number") {
      num = Math.min(num, max);
    }
    return num;
  };

  const updateContent = (newValue: string | undefined) => {
    if (!active) {
      node.textContent = newValue ?? "";

      return;
    }

    const processedValue = processValue(newValue ?? 0);
    node.textContent = formatter.format(processedValue);
  };

  updateContent(value);

  return {
    update(newOptions: Options) {
      updateContent(newOptions.value);
    },
  };
}
