<script lang="ts">
  import { getImageLink, reduceImageSize } from "$lib/common/utils";
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
  import { useCreateSchool, useUpdateShool } from "$lib/admin/queries";
  import {
    mapFormSchoolToAddSchoolPayload,
    mapFormSchoolToUpdateSchoolPayload,
  } from "$lib/admin/mappers";
  import type { UploadedFile } from "$lib/common/types";

  export let open: boolean = false;

  export let school: FormAdminSchool | null = null;

  const dispatch = createEventDispatcher();

  const createSchool = useCreateSchool({ withoutSuccessSnackbar: false });

  const updateSchool = useUpdateShool();

  const {
    form,
    isSubmitting,
    setInitialValues,
    setData,
    handleSubmit,
    reset,
    data,
    errors,
  } = createForm<FormAdminSchool>({
    initialValues: school ? school : INITIAL_VALUES,
    validate: validation,
    onSubmit: async (values) => {
      if (!school) {
        const mapped = await mapFormSchoolToAddSchoolPayload(values);

        await $createSchool.mutateAsync(mapped);
      } else {
        const mapped = await mapFormSchoolToUpdateSchoolPayload(values);

        await $updateSchool.mutateAsync({
          id: school.id,
          payload: mapped,
        });
      }

      dispatch("close");
    },
  });

  function handleClose() {
    dispatch("close");
  }

  async function handleFileChange({
    detail,
  }: CustomEvent<Array<File & UploadedFile>>) {
    try {
      const files = await Promise.all(
        detail.map(async (file) => {
          try {
            if ((file as UploadedFile).id) {
              return file;
            }

            const reduced = await reduceImageSize(file as File);

            const image = new File([reduced], file.name, {
              type: reduced.type,
            });

            return image;
          } catch (error) {
            snackbarStore.addMessage({
              message: "Error while reducing image size",
              type: "error",
            });

            return file;
          }
        })
      );

      const filtered = files.filter(
        (file, index, array) =>
          array.findIndex((f) => f.name === file.name) === index
      ) as Array<File & UploadedFile>;

      setData("images", filtered);
    } catch (error) {
      snackbarStore.addMessage({
        message: "Error while trying to upload images",
        type: "error",
      });
    }
  }

  $: {
    if (!open) {
      reset();
    } else {
      if (school) {
        setInitialValues(school);
      }
    }
  }

  $: totalSizeToUpload = $data.images.reduce((acc, file) => acc + file.size, 0);
</script>

<Modal bind:open onClose={handleClose} className="school-modal-root">
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
        type="button"
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
              <Switch bind:checked={$data.active} />
            </InputWithLabel>
          </div>
        </div>
      {/if}

      <div class="school-modal__images">
        <FileUploader
          files={$data.images}
          on:change={handleFileChange}
          labelTitle={"Upload images"}
          labelSubtitle={"Max total size to upload: 2MB"}
          accept={IMAGE_EXTENSIONS}
          {totalSizeToUpload}
          on:total-size-error={(event) => {
            snackbarStore.addMessage({
              message: `Max total size of files to upload is ${event.detail.maxTotalSize / 1024 / 1024}MB`,
              type: "error",
            });
          }}
        />
      </div>

      <div class="school-modal__blobs">
        {#each $data.images.map( (file) => (file.id ? getImageLink(file.id) : URL.createObjectURL(file)) ) as blob}
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
        type="button"
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
  @import "$lib/common/styles/media.scss";

  :global(.school-modal-root) {
    max-height: 100%;
    overflow: scroll;
    padding: 8px;
    width: 100%;
    display: flex;
    justify-content: center;
  }

  .school-modal {
    background-color: var(--uni-bg);
    box-shadow: var(--uni-shadow-paper);
    border-radius: 24px;
    max-width: 600px;
    width: 100%;
    height: 100%;
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
      flex-direction: column;
      gap: 16px;

      @include respond-to("desktop") {
        flex-direction: row;
      }
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
