export default function csvSerialDateToIso(serialDate: number) {
  const baseDate = new Date(1900, 0, -1);

  const isoDate = new Date(baseDate.getTime() + serialDate * 86400000);

  const formattedDate = isoDate.toISOString().slice(0, 10);

  return formattedDate;
}
