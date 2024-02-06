<script lang="ts">
  import rippleCreator from "$lib/common/actions/rippleCreator";

  export let label: string;
  export let variant: "primary" | "secondary" = "primary";
  export let contained: boolean = false;
  export let disabled: boolean = false;
  export let className: string = "";
  export let onClick: () => void = () => null;

  const ripple = rippleCreator({
    classListCallback: (node) => {
      node.classList.add(`ripple`);
      node.classList.add(`ripple-${variant}`);

      if (contained) {
        node.classList.add(`ripple-contained`);
      }
    },
  });
</script>

<button
  class={`button-root button ${className}`}
  class:primary-button={variant === "primary"}
  class:secondary-button={variant === "secondary"}
  class:contained-button={contained}
  class:disabled
  {disabled}
  use:ripple
  on:click={onClick}
>
  <slot name="start-icon" />
  {label}
  <slot name="end-icon" />
</button>

<style lang="scss">
  .button-root {
    height: var(--button-height);
    border-radius: var(--button-border-radius);
    border: 1px solid var(--divider-color);
    box-shadow: var(--shadow-button);
    padding: 0 20px;
    width: fit-content;
    transition:
      background-color var(--transition-default),
      color var(--transition-default);
    position: relative;
    overflow: hidden;
  }

  .button:not(.disabled) {
    cursor: pointer;
  }

  .primary-button {
    background-color: var(--primary-bg);
    color: var(--brand-primary-color);
    border-color: var(--brand-primary-color);

    &:hover {
      background-color: var(--primary-button-hover-bg);
      color: var(--primary-button-hover-color);
    }
  }

  .primary-button.disabled {
    background-color: var(--button-disabled-bg);
    color: var(--button-disabled-color);
    border-color: var(--button-disabled-bg);
  }

  .secondary-button {
    background-color: var(--primary-bg);
    color: var(--brand-secondary-color);
    border-color: var(--brand-secondary-color);

    &:hover {
      background-color: var(--secondary-button-hover-bg);
      color: var(--secondary-button-hover-color);
    }
  }

  .secondary-button.disabled {
    background-color: var(--button-disabled-bg);
    color: var(--button-disabled-color);
    border-color: var(--button-disabled-bg);
  }

  .primary-button.contained-button {
    background-color: var(--brand-primary-color);
    color: var(--opposite-text);
    border-color: var(--brand-primary-color);

    &:hover {
      background-color: var(--primary-button-contained-hover-bg);
      color: var(--primary-button-contained-hover-color);
    }
  }

  .primary-button.contained-button.disabled {
    background-color: var(--button-disabled-bg);
    color: var(--button-disabled-color);
    border-color: var(--button-disabled-bg);
  }

  .secondary-button.contained-button {
    color: var(--opposite-text);
    background-color: var(--brand-secondary-color);

    &:hover {
      background-color: var(--secondary-button-contained-hover-bg);
      color: var(--secondary-button-contained-hover-color);
    }
  }

  .secondary-button.contained-button.disabled {
    background-color: var(--button-disabled-bg);
    color: var(--button-disabled-color);
    border-color: var(--button-disabled-bg);
  }

  :global(.ripple) {
    position: absolute;
    border-radius: 50%;
    transform: scale(0);
    animation: ripple 600ms linear;
  }

  :global(.ripple-primary) {
    background: var(--brand-primary-color);
    opacity: 0.3;
  }

  :global(.ripple-primary.ripple-contained) {
    background: var(--primary-bg);
    opacity: 0.3;
  }

  :global(.ripple-secondary) {
    background: var(--brand-secondary-color);
    opacity: 0.3;
  }

  :global(.ripple-secondary.ripple-contained) {
    background: var(--opposite-text);
    opacity: 0.3;
  }

  @keyframes ripple {
    to {
      transform: scale(4);
      opacity: 0;
    }
  }
</style>
