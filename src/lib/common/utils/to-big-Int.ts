export default function toBigInt(value: number): bigint {
  return BigInt(Math.floor(Number(value)));
}
