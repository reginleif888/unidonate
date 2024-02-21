import * as Icons from "phosphor-svelte";
import type { TabRoute } from "./types";

export enum AppRoute {
  Home = "/",
  Donate = "/donate",
  ConfirmDonate = "/confirm-donate",
  Explorer = "/explorer",
  Donation = "/explorer/[donationId]",
}

export enum AdminRoute {
  Connect = "/admin",
  Schools = "/admin/schools",
  Students = "/admin/schools/[schoolId]/students",
  Owners = "/admin/owners",
}

export const APP_TABS_ROUTES: Array<TabRoute> = [
  {
    route: AppRoute.Home,
    label: "Home",
    Icon: Icons.House,
  },
  {
    route: AppRoute.Donate,
    label: "Donate",
    Icon: Icons.HandHeart,
  },
  {
    route: AppRoute.ConfirmDonate,
    label: "Confirm donate",
    Icon: Icons.ListChecks,
  },
  {
    route: AppRoute.Explorer,
    label: "Donation explorer",
    Icon: Icons.ListMagnifyingGlass,
  },
];

export const ADMIN_TABS_ROUTES: Array<TabRoute> = [
  {
    route: AdminRoute.Schools,
    label: "Schools & Students",
    Icon: Icons.GraduationCap,
  },
  {
    route: AdminRoute.Owners,
    label: "Owners",
    Icon: Icons.UserCircle,
  },
];
