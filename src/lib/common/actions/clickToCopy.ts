export function clickToCopy(node: Element, text: string) {
	async function copyText() {
		if (!document) {
			return;
		}

		try {
			await navigator.clipboard.writeText(text);

			node.dispatchEvent(
				new CustomEvent('copysuccess', {
					bubbles: true
				})
			);
		} catch (error) {
			node.dispatchEvent(
				new CustomEvent('copyerror', {
					bubbles: true,
					detail: error
				})
			);
		}
	}

	node.addEventListener('click', copyText);

	return {
		destroy() {
			node.removeEventListener('click', copyText);
		}
	};
}
