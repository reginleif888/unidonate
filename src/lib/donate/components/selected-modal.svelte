<script lang="ts">
  import { Modal } from "$lib/common/components";
  import type { FormStudent, FormSchool } from "../types";

  export let school: FormSchool | null;
  export let student: FormStudent | null;
  export let open: boolean;
  export let onClose: () => void = () => null;
</script>

<Modal {onClose} bind:open>
  <div class="selected-modal-content">
    {#if school}
      {school.name}
    {/if}
    {#if student}
      {student.firstName} {student.lastName}
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
