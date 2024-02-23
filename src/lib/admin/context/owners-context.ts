import type { Principal } from "@dfinity/principal";

export const OWNERS_CONTEXT_KEY = "OWNERS_CONTEXT_KEY";

export type OwnersContextType = {
  owners: Array<Principal>;
};
