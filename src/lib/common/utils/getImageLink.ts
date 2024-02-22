export default function getImageLink(id: string) {
  return `http://${process.env.CANISTER_ID_BACKEND}.localhost:4943/image?imgId=${id}`;
}
