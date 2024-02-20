import * as Icons from "phosphor-svelte";
import type { SelectItem } from "./types";

export const SCREEN = {
  smallTablet: 576, // Small devices (landscape phones, 576px and up)
  tablet: 768, // Medium devices (tablets, 768px and up)
  desktop: 992, // Large devices (desktops, 992px and up)
  largeDesktop: 1200, // Extra large devices (large desktops, 1200px and up)
  extraLargeDesktop: 1400, // Extra extra large devices (larger desktops, 1400px and up)
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
