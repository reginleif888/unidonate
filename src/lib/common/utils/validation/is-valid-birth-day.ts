import { CalendarDate, type DateValue } from "@internationalized/date";

export default function isValidBirthDate(dateValue: DateValue): boolean {
  if (!dateValue) {
    return false;
  }

  const earliestYear = new Date().getFullYear() - 120;

  const today = new CalendarDate(
    new Date().getFullYear(),
    new Date().getMonth() + 1,
    new Date().getDate()
  );

  if (
    new CalendarDate(dateValue.year, dateValue.month, dateValue.day).compare(
      today
    ) > 0 ||
    dateValue?.year < earliestYear
  ) {
    return false;
  }

  return true;
}
