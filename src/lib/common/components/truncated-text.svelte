<script lang="ts">
  import { onDestroy, onMount } from "svelte";
  import { clickToCopy } from "$lib/common/actions";
  import Tooltip from "./tooltip.svelte";
  import { Copy, Check } from "phosphor-svelte";

  export let text = "";
  export let withCopy: boolean = false;
  export let align: "left" | "center" | "right" = "center";

  let textElement: HTMLDivElement | null = null;
  let isEllipsized = false;
  let resizeObserver: ResizeObserver | null = null;

  let isCopied = false;

  function checkEllipsized() {
    if (textElement) {
      isEllipsized = textElement.scrollWidth > textElement.clientWidth;
    }
  }

  function handleCopySuccess() {
    isCopied = true;

    setTimeout(() => {
      isCopied = false;
    }, 1500);
  }

  onMount(() => {
    resizeObserver = new ResizeObserver((entries) => {
      checkEllipsized();
    });

    if (textElement) {
      resizeObserver.observe(textElement);
    }
  });

  onDestroy(() => {
    if (resizeObserver) {
      resizeObserver.disconnect();
    }
  });
</script>

<Tooltip disabled={!isEllipsized} fullWidth {align}>
  <div slot="trigger" class="text-container" bind:this={textElement}>
    {text}
  </div>
  <div slot="content" class="content">
    {text}
    {#if withCopy}
      {#if isCopied}
        <span class="copy-button"><Check /></span>
      {/if}

      {#if !isCopied}
        <button
          class="copy-button"
          use:clickToCopy={text}
          tabindex="-1"
          on:copysuccess={handleCopySuccess}
        >
          <Copy size={18} />
        </button>
      {/if}
    {/if}
  </div>
</Tooltip>

<style lang="scss">
  .text-container {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    cursor: default;
    width: 100%;
    color: var(--uni-on-bg);
  }

  .content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 8px;
  }

  .copy-button {
    background-color: transparent;
    border: unset;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    color: var(--uni-on-bg);

    &:focus {
      outline: none;
    }

    &:hover {
      color: var(--uni-primary);
    }
  }
</style>
