import type { FormAdminSchool } from "$lib/admin/types";
import type { IColumn } from "$lib/common/components";
import { ActionCell, ImageCell } from "./components";

export const columns: Array<IColumn<FormAdminSchool>> = [
  {
    key: "img",
    label: "",
    Cell: ImageCell,
    width: 100,
    minWidth: 100,
  },
  {
    key: "name",
    label: "Name",
    width: 400,
  },
  {
    key: "location",
    label: "Location",
  },
  {
    key: "website",
    label: "Website",
  },
  {
    key: "numberOfStudents",
    label: "Number of students",
    width: 300,
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