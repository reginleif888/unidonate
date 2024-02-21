export default function isValidWebsite(url: string): boolean {
  const regex =
    /^(?:http|ftp)s?:\/\/(?:www\.)?(?!www\.)[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[a-zA-Z]{2,11}(?:\/[a-zA-Z0-9@:%_+.~#?&//=]*)?$/;
  return regex.test(url);
}
