import type { Properties } from "csstype";

function camelToKebabCase(str: string): string {
  return str.replace(/([a-z0-9])([A-Z])/g, "$1-$2").toLowerCase();
}

export default function styleObjectToString(
  styles: Properties<string | number>
): string {
  return Object.entries(styles)
    .filter(([, value]) => value)
    .map(([key, value]) => `${camelToKebabCase(key)}: ${value}`)
    .join("; ");
}
