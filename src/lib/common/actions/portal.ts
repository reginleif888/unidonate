export default function portal(node: Element) {
  document.body.appendChild(node);

  return {
    destroy() {
      const parentNode = node.parentNode;

      if (parentNode) {
        parentNode.removeChild(node);
      }
    },
  };
}
