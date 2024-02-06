<script lang="ts">
  import { clickToCopy } from "$lib/common/actions/clickToCopy";
  import { Copy } from "phosphor-svelte";
  import Button from "./Button.svelte";
  import Tooltip from "./Tooltip.svelte";

  export let value: string = "";

  let copyText = "Copy me";

  let timer: NodeJS.Timeout | undefined = undefined;

  function handleCopySuccess() {
    clearTimeout(timer);

    copyText = "Copied 🎉";

    timer = setTimeout(() => {
      copyText = "Copy me";
    }, 3000);
  }

  function handleCopyError() {
    clearTimeout(timer);

    copyText = "Error 💥";

    timer = setTimeout(() => {
      copyText = "Copy me";
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
