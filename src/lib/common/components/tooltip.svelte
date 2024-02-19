<script lang="ts">
  import { Tooltip } from "bits-ui";
  import { flyAndScale } from "$lib/common/transitions";
  import type { TooltipSide } from "../types";
  import { onDestroy } from "svelte";

  export let disabled: boolean = false;
  export let side: TooltipSide = "top";
  export let closeDelay: number = 300;

  let open = false;

  onDestroy(() => {
    open = false;
  });
</script>

<Tooltip.Root openDelay={0} closeOnPointerDown={false} {closeDelay} bind:open>
  <Tooltip.Trigger
    class={`tooltip-trigger ${disabled ? "tooltip-trigger--disabled" : ""}`}
  >
    <slot name="trigger" />
  </Tooltip.Trigger>
  <Tooltip.Content
    transition={flyAndScale}
    transitionConfig={{ y: 8, duration: 150 }}
    sideOffset={8}
    {side}
  >
    <div class="tooltip-arrow-wrapper">
      <Tooltip.Arrow class="tooltip-arrow" />
    </div>
    <div class="tooltip-content body2">
      <slot name="content" />
    </div>
  </Tooltip.Content>
</Tooltip.Root>

<style>
  :global(.tooltip-trigger) {
    padding: 0;
    border: none;
    background: transparent;
    margin: 0;
    width: fit-content;
  }

  :global(.tooltip-trigger--disabled) {
    pointer-events: none;
  }

  :global(.tooltip-arrow-wrapper) {
    background-color: var(--uni-bg);
  }

  :global(.tooltip-arrow) {
    border-left: 1px solid var(--uni-divider-color);
    border-top: 1px solid var(--uni-divider-color);
  }

  :global(.tooltip-content) {
    background-color: var(--uni-bg);
    color: var(--uni-on-bg);
    border-color: var(--uni-divider-color);
    box-shadow: var(--uni-shadow-popover);
    outline: none;
    border-style: solid;
    border-radius: 8px;
    border-width: 1px;
    padding: 0.75rem;
    z-index: var(--uni-zIndex-tooltip);
  }
</style>