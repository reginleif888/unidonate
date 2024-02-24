<script lang="ts">
  import Button from "./button.svelte";
  import { createEventDispatcher } from "svelte";
  import Modal from "./modal.svelte";

  export let open: boolean = false;
  export let title: string = "";
  export let description: string = "";
  export let cancelButtonText: string = "Cancel";
  export let confirmButtonText: string = "Confirm";
  export let loading: boolean = false;

  const dispatch = createEventDispatcher();

  function handleCancel() {
    dispatch("cancel");
  }

  function handleConfirm() {
    dispatch("confirm");
  }
</script>

<Modal bind:open className="ui-component-confirm-modal">
  <div class="ui-component-confirm-modal__inner">
    <div class="body1 ui-component-confirm-modal__title">{title}</div>
    <div class="body2 ui-component-confirm-modal__description">
      {description}
    </div>
    <div class="ui-component-confirm-modal__controls">
      <Button
        label={cancelButtonText}
        fullWidth
        justify="center"
        on:click={handleCancel}
        variant="secondary"
      />
      <Button
        label={confirmButtonText}
        fullWidth
        justify="center"
        contained
        on:click={handleConfirm}
        notClickable={loading}
        {loading}
      />
    </div>
  </div>
</Modal>

<style lang="scss">
  :global(.ui-component-confirm-modal) {
    max-width: 540px;
    width: 100%;
  }

  .ui-component-confirm-modal {
    &__inner {
      padding: 24px;
      background-color: var(--uni-bg);
      background-color: var(--uni-bg);
      box-shadow: var(--uni-shadow-paper);
      border-radius: 24px;
      color: var(--uni-on-bg);
      display: flex;
      flex-direction: column;
      gap: 16px;
    }

    &__title {
      font-weight: bold;
    }

    &__controls {
      display: flex;
      gap: 8px;
      justify-content: flex-end;
    }
  }
</style>
