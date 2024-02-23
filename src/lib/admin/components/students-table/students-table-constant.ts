import type { FormAdminStudent } from "$lib/admin/types";
import type { IColumn } from "$lib/common/components";
import { formatDateValueToLocale } from "$lib/common/utils";
import { ActionCell, ActiveCell, ImageCell } from "./components";

export const columns: Array<IColumn<FormAdminStudent>> = [
  {
    key: "images",
    label: "",
    Cell: ImageCell,
    width: 100,
    minWidth: 100,
  },
  {
    key: "firstName",
    label: "First Name",
  },
  {
    key: "lastName",
    label: "Last Name",
  },
  {
    key: "dateOfBirth",
    label: "Date of Birth",
    format: (value) => formatDateValueToLocale(value),
  },
  {
    key: "grade",
    label: "Grade",
  },
  {
    key: "active",
    label: "Active",
    Cell: ActiveCell,
  },
  {
    key: "actions",
    noResize: true,
    minWidth: 80,
    width: 80,
    maxWidth: 80,
    label: "",
    Cell: ActionCell,
  },
];
