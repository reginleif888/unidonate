<script lang="ts">
  import { goto } from "$app/navigation";
  import { clickToCopy } from "$lib/common/actions";
  import { TruncatedText } from "$lib/common/components";
  import { AppRoute } from "$lib/common/routes";
  import type { FormDonation } from "$lib/donation-explorer/types";
  import { Check, Copy } from "phosphor-svelte";

  export let origin: FormDonation;

  let isCopied = false;

  function handleCopySuccess() {
    isCopied = true;

    setTimeout(() => {
      isCopied = false;
    }, 1500);
  }

  $: blockStreamLink = `https://blockstream.info/testnet/tx/${origin?.transactionId}`;
</script>

{#if origin.transactionId}
  <button>
    <TruncatedText text={origin.transactionId} showTooltip customTooltip>
      <div slot="custom-content">
        <div class="tooltip-row">
          {origin.transactionId}
          {#if isCopied}
            <span class="copy-button"><Check /></span>
          {/if}

          {#if !isCopied}
            <button
              class="copy-button"
              use:clickToCopy={origin.id}
              tabindex="-1"
              on:copysuccess={handleCopySuccess}
            >
              <Copy size={18} />
            </button>
          {/if}
        </div>
        <div class="tooltip-row">
          blockstream: <a
            href={blockStreamLink}
            rel="noopener noreferrer"
            target="_blank">link</a
          >
        </div>
      </div>
    </TruncatedText>
  </button>
{:else}
  N/A
{/if}

<style lang="scss">
  button {
    background-color: transparent;
    border: none;
    cursor: pointer;
    padding: 0;
    width: 100%;
  }

  .copy-button {
    color: var(--uni-on-bg);
  }

  .tooltip-row {
    display: flex;
    justify-content: flex-start;
    align-items: center;
    gap: 8px;

    a {
      color: var(--uni-primary);
    }
  }
</style>
