<script lang="ts">
  import { wait } from "$lib/common/utils";
  import {
    Button,
    Divider,
    FileUploader,
    Input,
    Modal,
    Switch,
    InputWithLabel,
  } from "$lib/common/components";
  import { X } from "phosphor-svelte";
  import type { FormAdminSchool } from "../../types";
  import { IMAGE_EXTENSIONS } from "$lib/common/constant";
  import { createEventDispatcher } from "svelte";
  import { INITIAL_VALUES } from "./school-modal.constant";
  import { snackbarStore } from "$lib/common/stores";
  import { createForm } from "felte";
  import { validation } from "./school-modal.validation";

  export let open: boolean = false;

  export let school: FormAdminSchool | null = null;

  const dispatch = createEventDispatcher();

  const { form, isSubmitting, handleSubmit, reset, data, errors } =
    createForm<FormAdminSchool>({
      initialValues: INITIAL_VALUES,
      validate: validation,
      onSubmit: async () => {
        await wait(2000);

        dispatch("close");
      },
    });

  const handleClose = () => {
    reset();

    dispatch("close");
  };

  $: {
    if (!open) {
      reset();
    }
  }
</script>

<Modal bind:open onClose={handleClose}>
  <form class="school-modal" use:form on:submit={handleSubmit}>
    <div class="school-modal__header">
      {#if school}
        <h4 class="h4">Edit school {school.name}</h4>
      {/if}

      {#if !school}
        <h4 class="h4">Create school</h4>
      {/if}

      <button
        class="school-modal__close-button"
        tabindex="-1"
        on:click={handleClose}><X size={32} /></button
      >
    </div>

    <Divider />

    <div class="school-modal__content">
      <div class="school-modal__content-row">
        <div class="school-modal__input-with-label-wrapper">
          <InputWithLabel
            label="Name"
            required
            fullWidth
            errorMessage={String($errors.name ?? "")}
          >
            <Input
              placeholder="School name..."
              bind:value={$data.name}
              error={Boolean($errors.name)}
            />
          </InputWithLabel>
        </div>

        <div class="school-modal__input-with-label-wrapper">
          <InputWithLabel
            label="Website"
            required
            fullWidth
            errorMessage={String($errors.website ?? "")}
          >
            <Input
              placeholder="School website..."
              bind:value={$data.website}
              error={Boolean($errors.website)}
            />
          </InputWithLabel>
        </div>
      </div>

      <div class="school-modal__content-row">
        <div class="school-modal__input-with-label-wrapper">
          <InputWithLabel
            label="Location"
            required
            fullWidth
            errorMessage={String($errors.location ?? "")}
          >
            <Input
              placeholder="School location..."
              bind:value={$data.location}
              error={Boolean($errors.location ?? "")}
            />
          </InputWithLabel>
        </div>
      </div>

      {#if school}
        <div class="school-modal__content-row">
          <div class="school-modal__input-with-label-wrapper">
            <InputWithLabel label="Active" fullWidth>
              <Switch />
            </InputWithLabel>
          </div>
        </div>
      {/if}

      <div class="school-modal__images">
        <FileUploader
          bind:files={$data.images}
          labelTitle={"Upload images"}
          labelSubtitle={"Max image size: 2MB"}
          accept={IMAGE_EXTENSIONS}
          maxSize={2 * 1024 * 1024}
          on:size-error={(event) => {
            snackbarStore.addMessage({
              message: `Max file size is ${event.detail.maxSize / 1024 / 1024}MB`,
              type: "error",
            });
          }}
        />
      </div>

      <div class="school-modal__blobs">
        {#each $data.images.map( (file) => (file.id ? "" : URL.createObjectURL(file)) ) as blob}
          <img src={blob} alt="uploaded-img" class="school-modal__blob" />
        {/each}
      </div>
    </div>

    <Divider />

    <div class="school-modal__footer">
      <Button
        fullWidth
        label="Cancel"
        contained
        variant="secondary"
        on:click={handleClose}
      />
      <Button
        fullWidth
        label={school ? "Update" : "Create"}
        type="submit"
        contained
        loading={$isSubmitting}
        notClickable={$isSubmitting}
      />
    </div>
  </form>
</Modal>

<style lang="scss">
  .school-modal {
    background-color: var(--uni-bg);
    box-shadow: var(--uni-shadow-paper);
    border-radius: 24px;
    max-width: 600px;
    width: 100%;
    color: var(--uni-on-bg);

    &__header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 16px;
      gap: 24px;
    }

    &__content {
      display: flex;
      flex-direction: column;
      gap: 16px;
      padding: 16px;
    }

    &__footer {
      display: flex;
      justify-content: flex-end;
      gap: 16px;
      padding: 16px;
    }

    &__content-row {
      display: flex;
      gap: 16px;
    }

    &__input-with-label-wrapper {
      width: 100%;
      min-width: 240px;
    }

    &__close-button {
      background-color: transparent;
      border: none;
      cursor: pointer;
      padding: 0;
      margin: 0;
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--uni-on-bg);

      &:focus {
        outline: none;
      }
    }

    &__images {
      min-height: 132px;
    }

    &__blobs {
      display: flex;
      gap: 8px;
      flex-wrap: wrap;
      min-height: 110px;
    }

    &__blob {
      width: 100px;
      height: 100px;
      object-fit: cover;
      border-radius: 8px;
    }
  }
</style>
