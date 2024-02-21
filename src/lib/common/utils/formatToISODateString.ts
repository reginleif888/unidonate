import { type DateValue } from "@internationalized/date";

export default function formatToISODateString(dateValue: DateValue): string {
  const month = String(dateValue.month).padStart(2, "0");
  const day = String(dateValue.day).padStart(2, "0");

  return `${dateValue.year}-${month}-${day}`;
}
