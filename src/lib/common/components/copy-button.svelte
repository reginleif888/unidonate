<script lang="ts">
  import { clickToCopy } from "$lib/common/actions";
  import { Copy } from "phosphor-svelte";
  import Button from "./button.svelte";
  import Tooltip from "./tooltip.svelte";
  import type { TooltipSide } from "../types";

  export let value: string = "";

  export let onCopySuccess: () => void = () => null;

  export let onCopyFailure: () => void = () => null;

  export let tooltipSide: TooltipSide = "top";

  let copyText = "Copy";

  let timer: NodeJS.Timeout | undefined = undefined;

  function handleCopySuccess() {
    clearTimeout(timer);

    copyText = "Copied 🎉";

    if (onCopySuccess) {
      onCopySuccess();
    }

    timer = setTimeout(() => {
      copyText = "Copy";
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

<Tooltip side={tooltipSide}
  ><span
    slot="trigger"
    class="copy-trigger"
    use:clickToCopy={value}
    on:copysuccess={handleCopySuccess}
    on:copyerror={handleCopyError}
  >
    <Button label="" variant="secondary">
      <svelte:fragment slot="end-icon">
        <Copy size={24} />
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
</style>
