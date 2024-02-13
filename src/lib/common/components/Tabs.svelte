<script lang="ts">
  import { onMount } from "svelte";
  import type { SelectItem } from "../types";

  export let variant: "primary" | "secondary" = "primary";
  export let options: SelectItem[] = [];
  export let selected: string | null = null;
  export let onChange: (value: string) => void = (value) => {
    selected = value;
  };
  export let fullWidth: boolean = false;
  let elements: Record<string, HTMLButtonElement | null> = {};

  onMount(() => {
    window.addEventListener("resize", () => {
      elements = elements;
    });
  });
</script>

<div
  class="root"
  class:primary={variant === "primary"}
  class:secondary={variant === "secondary"}
  style={`width: ${fullWidth ? "100%" : "auto"}`}
>
  {#each options as { label, disabled, value, Icon } (value)}
    <button
      bind:this={elements[value]}
      class="select-item"
      class:selected={selected === value}
      class:primary={variant === "primary"}
      class:secondary={variant === "secondary"}
      {disabled}
      on:click={() => {
        if (disabled) {
          return;
        }

        onChange(value);
      }}
    >
      {#if Icon}
        <Icon size={20} />
      {/if}<span>{label ?? ""}</span>
    </button>
  {/each}

  {#if selected && elements[selected ?? ""]}
    <div
      class="indicator"
      class:primary={variant === "primary"}
      class:secondary={variant === "secondary"}
      style={`width: ${elements[selected ?? ""]?.offsetWidth}px; height: ${elements[selected]?.offsetHeight}px; top: ${elements[selected]?.offsetTop}px; left: ${elements[selected]?.offsetLeft}px;`}
    />
  {/if}
</div>

<style lang="scss">
  .root {
    display: flex;
    gap: 8px;
    padding: 8px;
    border-radius: 10px;
    position: relative;
  }

  .select-item {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 32px;
    flex: 1;
    padding: 0;
    box-sizing: border-box;
    border: unset;
    background-color: transparent;
    border-radius: 10px;
    z-index: 2;
    gap: 8px;
    transition: all var(--uni-transition-default);
    cursor: pointer;

    &:disabled {
      cursor: default;
    }
  }

  .indicator {
    position: absolute;
    border-radius: 10px;
    transition: all var(--uni-transition-default);
    z-index: 1;
  }

  .root.primary {
    background-color: var(--uni-secondary);
  }

  .select-item.primary {
    color: var(--uni-text-color-200);

    &:disabled {
      color: var(--uni-text-color-600);
    }

    &:hover:not(:disabled) {
      color: var(--uni-text-color);
      background-color: var(--uni-text-color-800);
    }
  }

  .select-item.primary.selected {
    color: var(--uni-on-primary);

    &:hover {
      background-color: transparent;
      color: var(--uni-on-primary);
    }
  }

  .indicator.primary {
    background-color: var(--uni-primary);
  }

  .root.secondary {
    background-color: var(--uni-primary);
  }

  .select-item.secondary {
    color: var(--uni-on-primary);

    &:disabled {
      color: var(--uni-text-color-700);
    }

    &:hover:not(:disabled):not(.selected) {
      color: var(--uni-text-color);
      background-color: var(--uni-text-color-1000);
      opacity: 0.5;
    }
  }

  .select-item.secondary.selected {
    color: var(--uni-on-secondary);

    &:hover {
      background-color: transparent;
      color: var(--uni-on-secondary);
    }
  }

  .indicator.secondary {
    background-color: var(--uni-secondary);
  }
</style>
