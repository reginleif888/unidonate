import getDecimalSeparator from "./get-decimal-separator";

export default function satsToBtcString(sats: string) {
  let satsString = sats.toString();
  satsString = satsString.padStart(9, "0");
  const btcString =
    satsString.slice(0, -8) + getDecimalSeparator() + satsString.slice(-8);
  return btcString;
}
