<script lang="ts">
  import InputWithLabel from "./../../common/components/input-with-label.svelte";
  import {
    Button,
    Divider,
    FileUploader,
    Input,
    Modal,
    Switch,
  } from "$lib/common/components";
  import { X } from "phosphor-svelte";
  import type { FormAdminSchool } from "../types";
  import { IMAGE_EXTENSIONS } from "$lib/common/constant";
  import { createEventDispatcher } from "svelte";

  export let open: boolean = false;

  export let school: FormAdminSchool | null = null;

  let files: Array<File> = [];

  const dispatch = createEventDispatcher();

  const handleClose = () => {
    dispatch("close");
  };
</script>

<Modal bind:open onClose={handleClose}>
  <div class="school-modal">
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
          <InputWithLabel label="Name" required fullWidth>
            <Input placeholder="School name..." />
          </InputWithLabel>
        </div>

        <div class="school-modal__input-with-label-wrapper">
          <InputWithLabel label="Website" required fullWidth>
            <Input placeholder="School website..." />
          </InputWithLabel>
        </div>
      </div>

      <div class="school-modal__content-row">
        <div class="school-modal__input-with-label-wrapper">
          <InputWithLabel label="Location" required fullWidth>
            <Input placeholder="School location..." />
          </InputWithLabel>
        </div>
      </div>

      <div class="school-modal__content-row">
        <div class="school-modal__input-with-label-wrapper">
          <InputWithLabel label="Active" fullWidth>
            <Switch />
          </InputWithLabel>
        </div>
      </div>

      <div class="school-modal__images">
        <FileUploader
          bind:files
          labelTitle={"Upload images"}
          labelSubtitle={"Max image size: 2MB"}
          accept={IMAGE_EXTENSIONS}
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
      <Button fullWidth label={school ? "Update" : "Create"} contained />
    </div>
  </div>
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
