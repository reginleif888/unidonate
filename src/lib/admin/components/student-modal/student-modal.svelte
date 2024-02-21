<script lang="ts">
  import { CalendarDate } from "@internationalized/date";
  import {
    Button,
    DatePicker,
    Divider,
    FileUploader,
    Input,
    Modal,
    Switch,
    InputWithLabel,
  } from "$lib/common/components";
  import { X } from "phosphor-svelte";
  import type { FormAdminStudent } from "../../types";
  import { IMAGE_EXTENSIONS } from "$lib/common/constant";
  import { createEventDispatcher } from "svelte";
  import { snackbarStore } from "$lib/common/stores";
  import { createForm } from "felte";
  import { INITIAL_VALUES } from "./student-modal.constant";
  import { validation } from "./student-modal.validation";
  import { wait } from "$lib/common/utils";

  export let open: boolean = false;

  export let student: FormAdminStudent | null = null;

  let files: Array<File> = [];

  const dispatch = createEventDispatcher();

  const { form, isSubmitting, setFields, handleSubmit, reset, data, errors } =
    createForm<FormAdminStudent>({
      initialValues: INITIAL_VALUES,
      validate: validation,
      onSubmit: async (values) => {
        alert(JSON.stringify(values, null, 2));

        await wait(2000);

        dispatch("close");
      },
    });

  const handleClose = () => {
    dispatch("close");
  };

  $: {
    if (!open) {
      reset();
    }
  }
</script>

<Modal bind:open onClose={handleClose}>
  <form class="student-modal" use:form on:submit={handleSubmit}>
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
          <InputWithLabel
            label="First name"
            required
            fullWidth
            errorMessage={String($errors.firstName ?? "")}
          >
            <Input
              placeholder="First name..."
              bind:value={$data.firstName}
              error={Boolean($errors.firstName)}
            />
          </InputWithLabel>
        </div>

        <div class="student-modal__input-with-label-wrapper">
          <InputWithLabel
            label="Last name"
            required
            fullWidth
            errorMessage={String($errors.lastName ?? "")}
          >
            <Input
              placeholder="Last name..."
              bind:value={$data.lastName}
              error={Boolean($errors.lastName)}
            />
          </InputWithLabel>
        </div>
      </div>

      <div class="student-modal__content-row">
        <div class="student-modal__input-with-label-wrapper">
          <InputWithLabel
            label="Date of birth"
            required
            fullWidth
            errorMessage={String($errors.dateOfBirth ?? "")}
          >
            <DatePicker
              value={$data.dateOfBirth
                ? new CalendarDate(
                    $data.dateOfBirth.year,
                    $data.dateOfBirth.month,
                    $data.dateOfBirth.day
                  )
                : null}
              on:change={({ detail }) => {
                setFields("dateOfBirth", detail.value);
              }}
              error={Boolean($errors.dateOfBirth)}
            />
          </InputWithLabel>
        </div>

        <div class="student-modal__input-with-label-wrapper">
          <InputWithLabel
            label="Grade"
            required
            fullWidth
            errorMessage={String($errors.grade ?? "")}
          >
            <Input
              placeholder="Grade..."
              bind:value={$data.grade}
              error={Boolean($errors.grade)}
            />
          </InputWithLabel>
        </div>
      </div>

      {#if student}
        <div class="student-modal__content-row">
          <div class="student-modal__input-with-label-wrapper">
            <InputWithLabel label="Active" fullWidth>
              <Switch checked={$data.active} />
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
      <Button
        fullWidth
        label={student ? "Update" : "Create"}
        contained
        loading={$isSubmitting}
        notClickable={$isSubmitting}
      />
    </div>
  </form>
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
