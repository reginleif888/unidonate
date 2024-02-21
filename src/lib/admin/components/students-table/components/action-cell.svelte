<script lang="ts">
  import type { FormAdminStudent } from "$lib/admin/types";
  import { Tooltip } from "$lib/common/components";
  import { Pencil } from "phosphor-svelte";
  import StudentModal from "../../student-modal";

  export let origin: FormAdminStudent;

  let modalOpen: boolean = false;

  const handleEdit = () => {
    modalOpen = true;
  };

  const handleClose = () => {
    modalOpen = false;
  };
</script>

<div class="root">
  <Tooltip side="left" closeDelay={0}>
    <button slot="trigger" class="trigger" on:click={handleEdit}>
      <Pencil size={24} />
    </button>
    <div slot="content">Edit</div>
  </Tooltip>
</div>

<StudentModal bind:open={modalOpen} student={origin} on:close={handleClose} />

<style lang="scss">
  .root {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .trigger {
    color: var(--uni-on-bg);
    cursor: pointer;
    background-color: transparent;
    border: unset;
    padding: 0;

    &:hover {
      color: var(--uni-primary);
    }
  }
</style>
