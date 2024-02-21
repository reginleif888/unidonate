export type ActionType = {
	node: HTMLElement;
	destroy: () => void;
};

export default function clickOutside(node: HTMLElement): ActionType {
	const handleClick = (event: MouseEvent | TouchEvent) => {
		if (node && !node.contains(event.target as Node) && !event.defaultPrevented) {
			node.dispatchEvent(new CustomEvent('clickoutside'));
		}
	};

	document.addEventListener('mousedown', handleClick);
	document.addEventListener('touchstart', handleClick);

	return {
		destroy() {
			document.removeEventListener('mousedown', handleClick);
			document.removeEventListener('touchstart', handleClick);
		},
		node
	};
}
