import * as Icons from "phosphor-svelte";

export enum Route {
  Home = "/",
  Donate = "/donate",
  ConfirmDonate = "/confirm-donate",
  Explorer = "/explorer",
}

export const ROUTES = [
  {
    route: Route.Home,
    label: "Home",
    Icon: Icons.House,
  },
  {
    route: Route.Donate,
    label: "Donate",
    Icon: Icons.HandHeart,
  },
  {
    route: Route.ConfirmDonate,
    label: "Confirm donate",
    Icon: Icons.ListChecks,
  },
  {
    route: Route.Explorer,
    label: "Donation explorer",
    Icon: Icons.ListMagnifyingGlass,
  },
];
