<script lang="ts">
  import { Button, Divider, FileUploader, Modal } from "$lib/common/components";
  import { X } from "phosphor-svelte";
  import { SHEET_EXTENSIONS } from "$lib/common/constant";
  import { createEventDispatcher } from "svelte";
  import { snackbarStore } from "$lib/common/stores";
  import { xlsxToJson, type ColumnMapping } from "$lib/admin/utils";
  import filesToUint8Arrays from "$lib/common/utils/fromBlobToUint8Array";
  import type { FormAdminSchool } from "$lib/admin/types";
  import { reduceImageSize } from "$lib/common/utils";
  import type {
    AddSchoolPayload,
    ImageObject,
  } from "../../../../declarations/backend/backend.did";
  import { useCreateSchool } from "$lib/admin/queries";

  export let open: boolean = false;

  let files: Array<File> = [];

  let loading: boolean = false;

  const dispatch = createEventDispatcher();

  const columnMapping: Array<ColumnMapping> = [
    {
      index: 0,
      fieldName: "name",
    },
    {
      index: 1,
      fieldName: "website",
    },
    {
      index: 2,
      fieldName: "location",
    },
    {
      index: 3,
      fieldName: "img",
    },
  ];

  const createSchool = useCreateSchool();

  async function importFile() {
    try {
      loading = true;

      const data = await xlsxToJson({ file: files[0], columnMapping });

      const mapped: Array<AddSchoolPayload> = [];

      for (const school of data) {
        if (school.name && school.img && school.location && school.website) {
          const res = await fetch(school.img);

          const mimeType = res["headers"].get("content-type") || "image/jpeg";

          const blob = await res.blob();

          const reducedBlob = await reduceImageSize(blob);

          let encodedImg = await filesToUint8Arrays({ files: [reducedBlob] });

          const image: ImageObject = {
            id: [],
            mimeType,
            name: school.img.split("/").pop(),
            data: encodedImg[0],
          };

          mapped.push({
            name: school.name,
            location: school.location,
            website: school.website,
            images: [[image]],
          });
        }
      }

      for (const school of mapped) {
        await $createSchool.mutateAsync(school);
      }

      snackbarStore.addMessage({
        message: `${mapped.length} schools imported successfully!`,
        type: "success",
      });

      loading = false;

      dispatch("close");
    } catch (error) {
      loading = false;

      snackbarStore.addMessage({
        message: "Invalid file",
        type: "error",
      });

      console.error("error", error);
    }
  }

  const handleClose = () => {
    dispatch("close");
  };
</script>

<Modal bind:open onClose={handleClose}>
  <div class="student-modal">
    <div class="student-modal__header">
      <h4 class="h4">Import schools</h4>

      <button
        class="student-modal__close-button"
        tabindex="-1"
        on:click={handleClose}><X size={32} /></button
      >
    </div>
    <Divider />
    <div class="student-modal__content">
      <div class="student-modal__images">
        <FileUploader
          bind:files
          labelTitle={"Upload file"}
          labelSubtitle={"XLSX or CSV files"}
          accept={SHEET_EXTENSIONS}
          maxFiles={1}
          on:max-files-error={({ detail }) =>
            snackbarStore.addMessage({
              message: `You can only upload ${detail.maxFiles} file`,
              type: "error",
            })}
        />
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
        label={"Import"}
        on:click={importFile}
        contained
        notClickable={loading}
        {loading}
      />
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
      width: 400px;
      height: 400px;
      object-fit: cover;
      border-radius: 8px;
    }
  }
</style>
