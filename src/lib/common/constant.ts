import * as Icons from "phosphor-svelte";
import type { SelectItem } from "./types";

export const SCREEN = {
  smallTablet: 576,
  tablet: 768,
  desktop: 992,
  largeDesktop: 1200,
  extraLargeDesktop: 1400,
} as const;

export const MODES: Array<SelectItem> = [
  {
    label: "",
    value: "light",
    Icon: Icons.Sun,
  },
  {
    label: "",
    value: "dark",
    Icon: Icons.Moon,
  },
];

export const IMAGE_EXTENSIONS = [".jpg", ".jpeg", ".png", ".webp"];

export const SHEET_EXTENSIONS = [".csv", ".xls", ".xlsx"];
