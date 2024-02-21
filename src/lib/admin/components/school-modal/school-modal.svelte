<script lang="ts">
  import InputWithLabel from "../../../common/components/input-with-label.svelte";
  import {
    Button,
    Divider,
    FileUploader,
    Input,
    Modal,
    Switch,
  } from "$lib/common/components";
  import { X } from "phosphor-svelte";
  import type { FormAdminSchool } from "../../types";
  import { IMAGE_EXTENSIONS } from "$lib/common/constant";
  import { createEventDispatcher } from "svelte";
  import { createForm } from "svelte-forms-lib";
  import { INITIAL_VALUES } from "./school-modal.constant";
  import * as yup from "yup";
  import { snackbarStore } from "$lib/common/stores";

  export let open: boolean = false;

  export let school: FormAdminSchool | null = null;

  let files: Array<File> = [];

  const dispatch = createEventDispatcher();

  const { form, errors, handleSubmit } = createForm<FormAdminSchool>({
    initialValues: school ? INITIAL_VALUES : INITIAL_VALUES,
    validationSchema: yup.object().shape({
      name: yup.string().required("Name is required"),
      location: yup.string().required("Location is required"),
      website: yup.string().url("Invalid URL").required("Website is required"),
    }),
    onSubmit: async () => {
      snackbarStore.addMessage({
        message: "School created successfully",
        type: "success",
      });
    },
  });

  const handleClose = () => {
    dispatch("close");
  };

  $: {
    $form.website;
  }
</script>

<Modal bind:open onClose={handleClose}>
  <form class="school-modal" on:submit={handleSubmit}>
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
            errorMessage={$errors.name}
          >
            <Input
              placeholder="School name..."
              bind:value={$form.name}
              error={Boolean($errors.name)}
            />
          </InputWithLabel>
        </div>

        <div class="school-modal__input-with-label-wrapper">
          <InputWithLabel
            label="Website"
            required
            fullWidth
            errorMessage={$errors.website}
          >
            <Input
              placeholder="School website..."
              bind:value={$form.website}
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
            errorMessage={$errors.location}
          >
            <Input
              placeholder="School location..."
              bind:value={$form.location}
              error={Boolean($errors.location)}
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
          files={[{ id: "1", name: "image1.jpg", type: "image/jpeg" }]}
          labelTitle={"Upload images"}
          labelSubtitle={"Max image size: 2MB"}
          accept={IMAGE_EXTENSIONS}
          maxSize={2 * 1024 * 1024}
          on:change={(event) => {
            files = event.detail;

            console.log("=========", { files });
          }}
          on:size-error={(event) => {
            snackbarStore.addMessage({
              message: `Max file size is ${event.detail.maxSize / 1024 / 1024}MB`,
              type: "error",
            });
          }}
        />
      </div>

      <div class="school-modal__blobs">
        {#each files.map((file) => URL.createObjectURL(file)) as blob}
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
