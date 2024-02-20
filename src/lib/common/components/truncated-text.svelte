<script lang="ts">
  import { onDestroy, onMount } from "svelte";
  import { clickToCopy } from "$lib/common/actions";
  import Tooltip from "./tooltip.svelte";
  import { Copy } from "phosphor-svelte";

  export let text = "";
  export let withCopy: boolean = false;

  let textElement: HTMLDivElement | null = null;
  let isEllipsized = false;
  let resizeObserver: ResizeObserver | null = null;

  function checkEllipsized() {
    if (textElement) {
      isEllipsized = textElement.scrollWidth > textElement.clientWidth;
    }
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

<Tooltip disabled={!isEllipsized} fullWidth>
  <div slot="trigger" class="text-container" bind:this={textElement}>
    {text}
  </div>
  <div slot="content" class="content">
    {text}
    {#if withCopy}
      <button class="copy-button" use:clickToCopy={text} tabindex="-1">
        <Copy size={18} />
      </button>
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

    &:focus {
      outline: none;
    }

    &:hover {
      color: var(--uni-primary);
    }
  }
</style>
