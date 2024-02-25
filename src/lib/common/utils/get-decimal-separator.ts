export default function getDecimalSeparator() {
  const numberWithDecimal = 1.1;
  const formattedNumber = Intl.NumberFormat(window.navigator.language).format(
    numberWithDecimal
  );
  const decimalSeparator = formattedNumber.charAt(1);
  return decimalSeparator;
}
