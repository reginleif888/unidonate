import { CalendarDate } from "@internationalized/date";

export default function formatDateValueToLocale(
  dateValue: CalendarDate,
  locale?: string
): string {
  const date = new Date(dateValue.year, dateValue.month - 1, dateValue.day);

  const formatter = new Intl.DateTimeFormat(locale, {
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  return formatter.format(date);
}
