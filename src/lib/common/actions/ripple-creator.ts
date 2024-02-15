interface Options {
  classListCallback?: (element: HTMLSpanElement) => void;
}

const rippleHandler =
  ({ classListCallback }: Options) =>
  (event: MouseEvent) => {
    const button = event.currentTarget as HTMLButtonElement;
    const circle = document.createElement("span");
    const diameter = Math.max(button.clientWidth, button.clientHeight);
    const radius = diameter / 2;

    circle.style.width = circle.style.height = `${diameter}px`;
    circle.style.left = `${event.clientX - button.offsetLeft + window.scrollX - radius}px`;
    circle.style.top = `${event.clientY - button.offsetTop + window.scrollY - radius}px`;

    classListCallback?.(circle);

    const ripple = button.getElementsByClassName("ripple")[0];
    if (ripple) {
      ripple.remove();
    }

    button.appendChild(circle);
  };

const rippleCreator =
  ({ classListCallback }: Options) =>
  (node: HTMLElement) => {
    const handler = rippleHandler({ classListCallback });

    node.addEventListener("click", handler);

    return {
      destroy() {
        node.removeEventListener("click", handler);
      },
    };
  };

export default rippleCreator;
