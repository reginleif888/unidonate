<script lang="ts">
  import { clickToCopy } from "$lib/common/actions";
  import { Copy } from "phosphor-svelte";
  import Button from "./Button.svelte";
  import Tooltip from "./Tooltip.svelte";

  export let value: string = "";

  export let onCopySuccess: () => void = () => null;

  export let onCopyFailure: () => void = () => null;

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

<Tooltip
  ><span
    slot="trigger"
    class="copy-trigger"
    use:clickToCopy={value}
    on:copysuccess={handleCopySuccess}
    on:copyerror={handleCopyError}
  >
    <Button label="" variant="primary">
      <svelte:fragment slot="start-icon">
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
