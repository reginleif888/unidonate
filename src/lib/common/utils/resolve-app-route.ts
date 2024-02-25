export default function resolveAppRoute(route: string | null): string {
  if (!route) {
    return "/";
  }

  return route.replace("(app)", "").replace("//", "/");
}
