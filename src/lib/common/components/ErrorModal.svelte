<script>
  import Button from "./Button.svelte";
  import Modal from "./Modal.svelte";
  import { Prohibit } from "phosphor-svelte";
  import { errorModal } from "$lib/common/stores/errorModal";

  const handleClose = () => {
    errorModal.set({ isOpen: false, message: "" });
  };
</script>

<Modal open={$errorModal.isOpen} onClose={handleClose}>
  <svelte:fragment slot="content">
    <div class="content">
      <div class="error-icon-container">
        <Prohibit size="80" class="error-icon" />
      </div>
      <div class="subtitle2">
        {$errorModal.message}
      </div>
      <Button label="Ok, got it" onClick={handleClose}></Button>
    </div>
  </svelte:fragment>
</Modal>

<style>
  .content {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 16px;
    min-width: 260px;
    width: 100%;
    max-width: 340px;
  }

  .error-icon-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    height: 100%;
    width: 100px;
    height: 100px;
    background-color: var(--error-bg);
    border-radius: 50%;
  }

  :global(.error-icon-container .error-icon.error-icon path) {
    fill: var(--error-color);
  }
</style>
