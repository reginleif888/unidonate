export default function getImageLink(id: string) {
  /**
   * @todo fix this
   */
  return `http://${process.env.CANISTER_ID_BACKEND}.localhost:4943/image?imgId=${id}`;
}
