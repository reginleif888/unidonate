<script lang="ts">
  import { Modal } from "$lib/common/components";
  import type { FormStudent, FormUni } from "../types";

  export let uni: FormUni | null;
  export let student: FormStudent | null;
  export let open: boolean;
  export let onClose: () => void = () => null;
</script>

<Modal {onClose} bind:open>
  <div class="selected-modal-content">
    {#if uni}
      {uni.name}
    {/if}
  </div>
</Modal>

<style lang="scss">
  .selected-modal-content {
    padding: 24px;
    background-color: var(--uni-bg);
    color: var(--uni-on-bg);
    border-radius: 24px;
  }
</style>
