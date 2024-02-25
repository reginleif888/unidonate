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
  import { SCREEN } from "$lib/common/constant";
  import { screenWidthStore } from "$lib/common/stores";
  import { CurrencyBtc } from "phosphor-svelte";

  export let open: boolean = false;

  export let total: string = "";

  export let btcAddress: string = "";

  export let transactionId: string = "";

  export let onConfirm: () => void = () => null;

  function handleConfirm() {
    open = false;

    onConfirm();
  }

  let textToCopy = "";

  $: {
    textToCopy = `Total (BTC): ${total} \n\n BTC address: ${btcAddress} \n\n  Transaction Id: ${transactionId}`;
  }
</script>

<Modal
  bind:open
  closeOnEscape={false}
  closeOnOutsideClick={false}
  className="donation-modal__modal-root"
>
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
            squareSize={$screenWidthStore < SCREEN.desktop ? 200 : 300}
            codeValue="https://www.google.de/"
          />
        </div>

        <div class="donation-modal__inputs-wrapper">
          <input class="hidden-input" />
          <InputWithLabel label="Total (BTC)">
            <div class="donation-modal__input-wrapper">
              <Input readonly value={total}>
                <span slot="start-icon" class="btc-icon">
                  <CurrencyBtc weight="bold" />
                </span>
              </Input>
              <CopyButton tooltipSide="right" value={total} withoutTooltip />
            </div>
          </InputWithLabel>
          <InputWithLabel label="BTC address">
            <div class="donation-modal__input-wrapper">
              <Input readonly value={btcAddress} />
              <CopyButton
                tooltipSide="right"
                value={btcAddress}
                withoutTooltip
              />
            </div>
          </InputWithLabel>
          <InputWithLabel label="Donation transaction Id (DTI)">
            <div class="donation-modal__input-wrapper">
              <Input readonly value={transactionId} />
              <CopyButton
                tooltipSide="right"
                value={transactionId}
                withoutTooltip
              />
            </div>
          </InputWithLabel>
          <CopyButton
            tooltipSide="right"
            value={textToCopy}
            label="Copy all info"
            withoutTooltip
          />
        </div>
      </div>
    </div>

    <Divider />

    <div class="donation-modal__footer">
      <div class="donation-modal__confirm-button_wrapper">
        <Button
          label="I save it, verify! 🎉"
          contained
          fullWidth
          justify="center"
          on:click={handleConfirm}
        />
      </div>
    </div>
  </div>
</Modal>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  :global(.donation-modal__modal-root) {
    width: 100%;
    justify-content: center;
    display: flex;
  }

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
    max-height: 98vh;
    overflow: auto;

    &__qr-code-wrapper {
      display: flex;
      justify-content: center;
    }

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
      flex-direction: column;

      @include respond-to("desktop") {
        flex-direction: row;
      }
    }

    &__footer {
      display: flex;
      justify-content: flex-end;
      padding: 16px 24px;
    }

    &__confirm-button_wrapper {
      max-width: fit-content;
      width: 100%;
    }

    &__inputs-wrapper {
      width: 100%;
      display: flex;
      flex-direction: column;
      gap: 16px;
    }

    &__input-wrapper {
      width: 100%;
      display: flex;
      gap: 8px;
    }
  }

  .btc-icon {
    position: relative;
    top: 2px;
  }
</style>
