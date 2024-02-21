<script lang="ts">
  import {
    Button,
    Input,
    InputWithLabel,
    Modal,
    QrCode,
    InlineNotification,
    Divider,
    CopyButton,
  } from "$lib/common/components";
  import { CurrencyBtc } from "phosphor-svelte";

  export let open: boolean = false;

  export let total: string = "";

  export let btcAddress: string = "";

  export let transactionId: string = "";

  export let onConfirm: () => void = () => null;

  let isCopied: boolean = false;

  function handleCopy() {
    isCopied = true;
  }

  function handleConfirm() {
    open = false;

    onConfirm();
  }

  let textToCopy = "";

  $: {
    textToCopy = `Total (BTC): ${total} \n\n BTC address: ${btcAddress} \n\n  Transaction Id: ${transactionId}`;
  }

  $: {
    if (!open) {
      isCopied = false;
    }
  }
</script>

<Modal bind:open closeOnEscape={false} closeOnOutsideClick={false}>
  <div class="donation-modal">
    <div class="donation-modal__header">
      <h4 class="h4">Donation information</h4>
    </div>

    <div class="donation-modal__content">
      <div class="donation-modal__first-section">
        <InlineNotification
          title="Warning!"
          message="You need to copy the following information and save it somewhere before confirming. Additionally, you can use the following QR code to make your donation via a mobile application."
          type="warning"
          fullWidthText
        />
      </div>

      <div class="donation-modal__second-section">
        <div class="donation-modal__qr-code-wrapper">
          <QrCode
            id="donation"
            squareSize={315}
            codeValue="https://www.google.de/"
          />
        </div>

        <div class="donation-modal__inputs-wrapper">
          <input class="hidden-input" />
          <InputWithLabel label="Total (BTC)">
            <Input readOnly value={total}>
              <span slot="start-icon" class="btc-icon">
                <CurrencyBtc weight="bold" />
              </span>
            </Input>
          </InputWithLabel>
          <InputWithLabel label="BTC address">
            <Input readOnly value={btcAddress} />
          </InputWithLabel>
          <InputWithLabel label="Donation transaction Id (DTI)">
            <Input readOnly value={transactionId} />
          </InputWithLabel>
          <CopyButton
            onCopyFailure={handleCopy}
            onCopySuccess={handleCopy}
            tooltipSide="right"
            value={textToCopy}
          />
        </div>
      </div>
    </div>

    <Divider />

    <div class="donation-modal__footer">
      <div class="donation-modal__confirm-button_wrapper">
        <Button
          label="Confirm"
          contained
          fullWidth
          justify="center"
          disabled={!isCopied}
          on:click={handleConfirm}
        />
      </div>
    </div>
  </div>
</Modal>

<style lang="scss">
  .hidden-input {
    height: 0;
    opacity: 0;
    pointer-events: none;
    position: absolute;
  }

  .donation-modal {
    background-color: var(--uni-bg);
    box-shadow: var(--uni-shadow-paper);
    border-radius: 24px;
    max-width: 800px;
    width: auto;
    color: var(--uni-on-bg);

    &__header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 24px;
      padding: 24px;
      padding-bottom: 0px;
    }

    &__content {
      margin-bottom: 24px;
      display: flex;
      flex-direction: column;
      gap: 16px;
      padding: 0 24px;
    }

    &__second-section {
      display: flex;
      gap: 16px;
    }

    &__footer {
      display: flex;
      justify-content: flex-end;
      padding: 16px 24px;
    }

    &__confirm-button_wrapper {
      max-width: 160px;
      width: 100%;
    }

    &__inputs-wrapper {
      width: 400px;
      display: flex;
      flex-direction: column;
      gap: 16px;
    }
  }

  .btc-icon {
    position: relative;
    top: 2px;
  }
</style>
