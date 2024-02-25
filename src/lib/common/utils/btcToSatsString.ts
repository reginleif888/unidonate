import getDecimalSeparator from "./getDecimalSeparator";

export default function btcToSatsString(btc: string) {
  let [whole, fractional] = btc.split(getDecimalSeparator());
  fractional = fractional || "";
  fractional = fractional.padEnd(8, "0");
  const sats = whole + fractional;
  return parseInt(sats, 10).toString();
}
