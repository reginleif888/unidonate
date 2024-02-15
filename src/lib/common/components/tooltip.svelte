<script lang="ts">
  import { Tooltip } from "bits-ui";
  import { flyAndScale } from "$lib/common/transitions";
</script>

<Tooltip.Root openDelay={0} closeOnPointerDown={false}>
  <Tooltip.Trigger class="tooltip-trigger">
    <slot name="trigger" />
  </Tooltip.Trigger>
  <Tooltip.Content
    transition={flyAndScale}
    transitionConfig={{ y: 8, duration: 150 }}
    sideOffset={8}
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
    width: 100%;
  }
  :global(.tooltip-arrow-wrapper) {
    background-color: var(--secondary-bg);
  }

  :global(.tooltip-arrow) {
    border-left: 1px solid var(--divider-color);
    border-top: 1px solid var(--divider-color);
  }

  :global(.tooltip-content) {
    background-color: var(--secondary-bg);
    border-color: var(--divider-color);
    box-shadow: var(--shadow-popover);
    outline: none;
    border-style: solid;
    border-radius: var(--input-border-radius);
    border-width: 1px;
    padding: 0.75rem;
    z-index: var(--uni-zIndex-tooltip);
  }
</style>
