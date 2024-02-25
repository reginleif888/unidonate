<script lang="ts">
  import { useOwners, useRemoveOwner } from "$lib/admin/queries";
  import type { FormAdminPrincipal } from "$lib/admin/types";
  import { ConfirmModal, Tooltip } from "$lib/common/components";
  import { Principal } from "@dfinity/principal";
  import { UserMinus } from "phosphor-svelte";

  export let origin: FormAdminPrincipal;

  let modalOpen = false;
  let loading: boolean = false;
  let ownersQuery: ReturnType<typeof useOwners>;

  const removeOwner = useRemoveOwner();

  function handleConfirmModalOpen() {
    modalOpen = true;
  }

  function handleCancel() {
    modalOpen = false;
  }

  async function handleConfirm() {
    try {
      loading = true;

      await $removeOwner.mutateAsync(Principal.fromText(origin.id));
    } catch (error) {
    } finally {
      loading = false;

      modalOpen = false;
    }
  }

  $: ownersQuery = useOwners();

  $: disabled = Number($ownersQuery.data?.length ?? 0) <= 1;
</script>

<div class="root">
  <Tooltip side="left" closeDelay={0}>
    <button
      {disabled}
      slot="trigger"
      class="trigger"
      class:trigger--disabled={disabled}
      on:click={handleConfirmModalOpen}
    >
      <UserMinus size={24} />
    </button>
    <div slot="content">
      {disabled ? "You can not delete last owner" : "Delete"}
    </div>
  </Tooltip>
</div>

<ConfirmModal
  bind:open={modalOpen}
  title="Are you sure you want to delete this owner?"
  description="If you delete this owner, they will lose access to the admin panel and will only have access to public functions."
  on:confirm={handleConfirm}
  on:cancel={handleCancel}
  {loading}
/>

<style lang="scss">
  .root {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-evenly;
    gap: 16px;
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

    &--disabled {
      pointer-events: none;
      opacity: 0.2;
    }
  }
</style>
