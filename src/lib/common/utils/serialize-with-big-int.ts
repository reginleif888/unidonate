export default function serializeWithBigInt(obj: any): string {
  const bigIntToString = (value: any) => {
    if (typeof value === "bigint") {
      return Number(value);
    }
    return value;
  };

  const replacer = (_: string, value: any) => {
    if (typeof value === "object" && value !== null) {
      for (const k in value) {
        value[k] = replacer(k, value[k]);
      }
      return value;
    }

    return bigIntToString(value);
  };

  return JSON.stringify(obj, replacer);
}
