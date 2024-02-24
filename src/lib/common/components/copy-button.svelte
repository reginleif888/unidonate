<script lang="ts">
  import { clickToCopy } from "$lib/common/actions";
  import { Copy, Check } from "phosphor-svelte";
  import Button from "./button.svelte";
  import Tooltip from "./tooltip.svelte";
  import type { TooltipSide } from "../types";
  import { onDestroy } from "svelte";

  export let value: string = "";

  export let onCopySuccess: () => void = () => null;

  export let onCopyFailure: () => void = () => null;

  export let tooltipSide: TooltipSide = "top";

  export let label: string = "";

  export let withoutTooltip: boolean = false;

  let copyText = "Copy";

  let isCopied: boolean = false;

  let timer: NodeJS.Timeout | undefined = undefined;

  function handleCopySuccess() {
    clearTimeout(timer);

    copyText = "Copied 🎉";

    isCopied = true;

    if (onCopySuccess) {
      onCopySuccess();
    }

    timer = setTimeout(() => {
      copyText = "Copy";

      isCopied = false;
    }, 3000);
  }

  function handleCopyError() {
    clearTimeout(timer);

    copyText = "Error 💥";

    if (onCopyFailure) {
      onCopyFailure();
    }

    timer = setTimeout(() => {
      copyText = "Copy";
    }, 3000);
  }
</script>

<Tooltip side={tooltipSide} disabled={withoutTooltip}>
  <span
    slot="trigger"
    class="copy-trigger"
    use:clickToCopy={value}
    on:copysuccess={handleCopySuccess}
    on:copyerror={handleCopyError}
  >
    <Button {label} variant="secondary">
      <svelte:fragment slot="end-icon">
        <div class="copy-inner-button-wrapper">
          {#if withoutTooltip && isCopied}
            <Check />
          {:else}
            <Copy size={24} />
          {/if}
        </div>
      </svelte:fragment>
    </Button>
  </span>
  <span slot="content">{copyText}</span>
</Tooltip>

<style>
  .copy-trigger {
    cursor: pointer;
  }

  :global(.copy-trigger path) {
    fill: var(--secondary-color);
  }

  .copy-inner-button-wrapper {
    min-height: 24px;
    min-width: 24px;
    position: relative;
    top: 2px;
  }
</style>
