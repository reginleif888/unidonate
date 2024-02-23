import type { FormAdminPrincipal } from "$lib/admin/types";
import type { IColumn } from "$lib/common/components";
import { ActionCell } from "./components";

export const columns: Array<IColumn<FormAdminPrincipal>> = [
  {
    key: "id",
    label: "",
    align: "left",
  },

  {
    key: "actions",
    noResize: true,
    minWidth: 100,
    width: 120,
    maxWidth: 120,
    label: "",
    Cell: ActionCell,
  },
];
