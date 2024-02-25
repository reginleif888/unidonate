<script lang="ts">
  import { Principal } from "@dfinity/principal";
  import { useCreateOwner } from "$lib/admin/queries";
  import {
    Button,
    Input,
    InputWithLabel,
    Tooltip,
    Spinner,
    InlineNotification,
  } from "$lib/common/components";
  import { Plus } from "phosphor-svelte";

  let value: string = "";
  let error: string = "";

  const createOwner = useCreateOwner();

  async function handleCreteOwner() {
    try {
      const principal = Principal.fromText(value);

      await $createOwner.mutateAsync(principal);

      value = "";
      error = "";
    } catch (e) {
      error = String(e);
    }
  }

  function handleChange() {
    error = "";
  }

  $: loading = $createOwner.isLoading;
</script>

<div class="root">
  <div class="create-owner-form">
    <div class="create-owner-form__input-wrapper">
      <InputWithLabel label="Create owner" fullWidth>
        <Input
          placeholder="Owner..."
          bind:value
          error={Boolean(error)}
          on:input={handleChange}
        />
      </InputWithLabel>
    </div>

    <div class="create-owner-form__add-button-wrapper">
      <Tooltip disabled={!value}>
        <span slot="trigger">
          <Button
            contained
            onlyIcon
            disabled={!value || loading}
            on:click={handleCreteOwner}
            notClickable={loading}
          >
            <div
              slot="start-icon"
              class={loading
                ? "create-owner-form__spinner-wrapper"
                : "create-owner-form__add-button-icon"}
            >
              {#if loading}
                <Spinner />
              {/if}

              {#if !loading}
                <Plus size={24} weight="bold" />
              {/if}
            </div>
          </Button>
        </span>
        <span slot="content">Create new owner</span>
      </Tooltip>
    </div>
  </div>

  {#if error}
    <InlineNotification type="error" title="Oops..." message={String(error)} />
  {/if}
</div>

<style lang="scss">
  .root {
    display: flex;
    flex-direction: column;
    gap: 16px;
    width: 100%;
  }

  .create-owner-form {
    display: flex;
    align-items: flex-end;
    gap: 8px;
    max-width: 420px;
    width: 100%;

    &__add-button-icon {
      position: relative;
      top: 2px;
      padding: 0 3px;
    }

    &__spinner-wrapper {
      padding: 0 5px;
    }

    &__input-wrapper {
      width: 100%;
    }
  }
</style>
