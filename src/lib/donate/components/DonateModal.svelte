<script lang="ts">
  import Modal from "$lib/common/components/Modal.svelte";
  import QrCode from "$lib/common/components/QrCode.svelte";
  import CopyButton from "$lib/common/components/CopyButton.svelte";
  import TextInput from "$lib/common/components/TextInput.svelte";
  import Button from "$lib/common/components/Button.svelte";
  import { goto } from "$app/navigation";

  export let donateTransactionId: string = "";

  export let address: string = "";

  export let amount: string = "";

  export let open: boolean = false;

  let copied: boolean = false;
</script>

<Modal {open}>
  <div class="root" slot="content">
    <h2 class="h2 title">Pay donation</h2>
    <span class="subtitle1 amount">
      {amount} BTC
    </span>

    <div class="qr-code-wrapper">
      <QrCode
        codeValue={`bitcoin:${address}?amount=${amount}`}
        squareSize="200"
        id="donation-qr-code"
      />
    </div>

    <div class="transaction-wrapper">
      <TextInput
        disabled
        label="Donation transaction Id"
        value={donateTransactionId}
      />
    </div>
    <div class="transaction-wrapper">
      <TextInput disabled label="Payment address" value={address} />
    </div>
    <div class="transaction-wrapper">
      <div class="copy-button-wrappe">
        <CopyButton
          value={`
          Payment address: ${address}
          Donation transaction Id: ${donateTransactionId}
          Amount: ${amount} BTC
          `}
          onCopySuccess={() => {
            copied = true;
          }}
          onCopyFailure={() => {
            copied = true;
          }}
        />
      </div>
      <Button
        label="Done"
        disabled={!copied}
        contained
        onClick={() => {
          goto(`/confirm-donate?donateTransactionId=${donateTransactionId}`);
        }}
      />
    </div>
  </div>
</Modal>

<style>
  .root {
    display: grid;
    gap: 20px;
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  }

  .qr-code-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .title {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
  }

  .transaction-wrapper {
    display: flex;
    align-items: flex-end;
  }

  .copy-button-wrapper {
    height: 52px;
  }

  .amount {
    display: flex;
    align-items: center;
    justify-content: center;
  }
</style>
