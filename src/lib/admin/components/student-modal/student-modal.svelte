<script lang="ts">
  import InputWithLabel from "../../../common/components/input-with-label.svelte";
  import {
    Button,
    DatePicker,
    Divider,
    FileUploader,
    Input,
    Modal,
    Switch,
  } from "$lib/common/components";
  import { X } from "phosphor-svelte";
  import type { FormAdminStudent } from "../../types";
  import { IMAGE_EXTENSIONS } from "$lib/common/constant";
  import { createEventDispatcher } from "svelte";
  import { createForm } from "svelte-forms-lib";
  import { snackbarStore } from "$lib/common/stores";

  export let open: boolean = false;

  export let student: FormAdminStudent | null = null;

  let files: Array<File> = [];

  createForm;

  const dispatch = createEventDispatcher();

  const handleClose = () => {
    dispatch("close");
  };
</script>

<Modal bind:open onClose={handleClose}>
  <div class="student-modal">
    <div class="student-modal__header">
      {#if student}
        <h4 class="h4">Edit student {student.firstName} {student.lastName}</h4>
      {/if}

      {#if !student}
        <h4 class="h4">Create student</h4>
      {/if}

      <button
        class="student-modal__close-button"
        tabindex="-1"
        on:click={handleClose}><X size={32} /></button
      >
    </div>
    <Divider />
    <div class="student-modal__content">
      <div class="student-modal__content-row">
        <div class="student-modal__input-with-label-wrapper">
          <InputWithLabel label="First name" required fullWidth>
            <Input placeholder="First name..." />
          </InputWithLabel>
        </div>

        <div class="student-modal__input-with-label-wrapper">
          <InputWithLabel label="Last name" required fullWidth>
            <Input placeholder="Last name..." />
          </InputWithLabel>
        </div>
      </div>

      <div class="student-modal__content-row">
        <div class="student-modal__input-with-label-wrapper">
          <InputWithLabel label="Date of birth" required fullWidth>
            <DatePicker value={null} />
          </InputWithLabel>
        </div>

        <div class="student-modal__input-with-label-wrapper">
          <InputWithLabel label="Grade" required fullWidth>
            <Input placeholder="Grade..." />
          </InputWithLabel>
        </div>
      </div>

      {#if student}
        <div class="student-modal__content-row">
          <div class="student-modal__input-with-label-wrapper">
            <InputWithLabel label="Active" fullWidth>
              <Switch />
            </InputWithLabel>
          </div>
        </div>
      {/if}

      <div class="student-modal__images">
        <FileUploader
          bind:files
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

      <div class="student-modal__blobs">
        {#each files.map((file) => URL.createObjectURL(file)) as blob}
          <img src={blob} alt="uploaded-img" class="student-modal__blob" />
        {/each}
      </div>
    </div>

    <Divider />
    <div class="student-modal__footer">
      <Button
        fullWidth
        label="Cancel"
        contained
        variant="secondary"
        on:click={handleClose}
      />
      <Button fullWidth label={student ? "Update" : "Create"} contained />
    </div>
  </div>
</Modal>

<style lang="scss">
  .student-modal {
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
