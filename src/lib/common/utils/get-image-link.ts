import checkIsProductionBuild from "./check-is-production-build";

type BuildType = "production" | "development";

const mapBuildTypeToDomain: Record<BuildType, string> = {
  production: ".icp0.io",
  development: "localhost:4943",
};

export default function getImageLink(id: string) {
  const buildType: BuildType = checkIsProductionBuild()
    ? "production"
    : "development";

  const domain = mapBuildTypeToDomain[buildType];

  return `http://${process.env.CANISTER_ID_BACKEND}.${domain}/image?imgId=${id}`;
}
