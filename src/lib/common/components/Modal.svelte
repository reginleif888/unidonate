<script lang="ts">
  import { Dialog } from "bits-ui";
  import { flyAndScale } from "$lib/common/transitions";
  import { fade } from "svelte/transition";

  export let open: boolean = false;

  export let onClose = () => {
    open = false;
  };
</script>

<Dialog.Root
  {open}
  onOpenChange={(o) => {
    open = o;
  }}
  on:closeFocus={onClose}
  closeOnOutsideClick={false}
>
  <Dialog.Portal>
    <Dialog.Overlay
      transition={fade}
      transitionConfig={{ duration: 150 }}
      class="dialog__overlay"
    />
    <Dialog.Content transition={flyAndScale} class="dialog__content"
      ><slot /></Dialog.Content
    >
  </Dialog.Portal>
</Dialog.Root>

<style>
  :global(.dialog__overlay) {
    opacity: 0.5;
    background-color: var(--overlay-bg);
    backdrop-filter: blur(3.5px);
    filter: blur(3.5px);
    inset: 0;
    position: fixed;
    z-index: 50;
  }

  :global(.dialog__content) {
    position: fixed;
    left: 50%;
    top: 50%;
    z-index: 50;
    width: fit-content;
    max-width: 94%;
    transform: translate(-50%, -50%);
    background-color: var(--secondary-bg);
    padding: 1.25rem;
  }
</style>
