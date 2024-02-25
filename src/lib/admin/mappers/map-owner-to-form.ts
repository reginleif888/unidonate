import type { Principal } from "@dfinity/principal";
import type { FormAdminPrincipal } from "../types";

export default function mapSchoolToForm(owner: Principal): FormAdminPrincipal {
  return {
    id: owner.toText(),
    principal: owner,
  };
}
