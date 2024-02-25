export default function isProductionBuild() {
  return ["playground", "ic"].includes(process.env.DFX_NETWORK ?? "local");
}
