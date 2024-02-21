<script lang="ts">
  import { Dialog } from "bits-ui";
  import { flyAndScale } from "$lib/common/transitions";
  import { fade } from "svelte/transition";

  export let open: boolean = false;

  export let align: "center" | "start" = "center";

  export let closeOnEscape: boolean = true;

  export let closeOnOutsideClick: boolean = true;

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
  {closeOnOutsideClick}
  {closeOnEscape}
>
  <Dialog.Portal>
    <Dialog.Overlay
      transition={fade}
      transitionConfig={{ duration: 150 }}
      class="modal__overlay"
    />
    <Dialog.Content
      transition={flyAndScale}
      class={`modal__content ${align === "start" ? "modal__content--start" : ""}`}
    >
      <slot />
    </Dialog.Content>
  </Dialog.Portal>
</Dialog.Root>

<style>
  :global(.modal__overlay) {
    background-color: var(--uni-overlay-bg);
    backdrop-filter: blur(8px);
    inset: 0;
    position: fixed;
    z-index: var(--uni-zIndex-modal);
  }

  :global(.modal__content) {
    position: fixed;
    left: 50%;
    top: 50%;
    z-index: 50;
    width: fit-content;
    max-width: 94%;
    transform: translate(-50%, -50%);
    background-color: var(--secondary-bg);
    padding: 1.25rem;
    z-index: var(--uni-zIndex-modal-content);
  }

  :global(.modal__content--start) {
    top: 12%;
  }

  :global(.modal__content:focus-visible) {
    outline: none;
  }
</style>
