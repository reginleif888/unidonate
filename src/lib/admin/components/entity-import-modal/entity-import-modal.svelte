<script lang="ts" generics="T">
  import {
    Button,
    Divider,
    FileUploader,
    Modal,
    Progress,
  } from "$lib/common/components";
  import { X } from "phosphor-svelte";
  import { SHEET_EXTENSIONS } from "$lib/common/constant";
  import { createEventDispatcher } from "svelte";
  import { snackbarStore } from "$lib/common/stores";
  import { xlsxToJson, type ColumnMapping } from "$lib/admin/utils";
  import { reduceImageSize, fromBlobToUint8Array } from "$lib/common/utils";
  import type { ImageObject } from "../../../../declarations/backend/backend.did";

  type Row = Record<string, string> & { image?: ImageObject };

  type $$Props = {
    title: string;
    open: boolean;
    columnMapping: Array<ColumnMapping>;
    dataMapper: (data: Array<Row>) => T;
    onImport: (data: Array<T>) => Promise<void>;
    progress: number;
    progressLabel: string;
  };

  export let title = "";
  export let open = false;
  export let columnMapping: Array<ColumnMapping>;
  export let dataMapper: (data: Array<Row>) => T;
  export let onImport: (data: Array<T>) => Promise<void>;
  export let progress: number;
  export let progressLabel: string;

  let files: Array<File> = [];
  let loading: boolean = false;

  const dispatch = createEventDispatcher();

  function checkIsRequiredFilled(row: Row) {
    return Object.keys(row).every((key) => {
      const linkedColumn = columnMapping.find(
        (column) => column.fieldName === key
      );

      if (!linkedColumn) {
        return false;
      }

      if (!linkedColumn.required) {
        return true;
      }

      return Boolean(row[key]);
    });
  }

  function checkIsImageRow(row: Row) {
    return Object.keys(row).some((key) => {
      const linkedColumn = columnMapping.find(
        (column) => column.fieldName === key
      );

      if (!linkedColumn) {
        return false;
      }

      return linkedColumn.img;
    });
  }

  async function importFile() {
    if (!files.length) {
      return;
    }

    loading = true;

    let data = [];

    try {
      progress = 0;

      progressLabel = "Parsing file";

      data = await xlsxToJson({ file: files[0], columnMapping });

      progress = 5;
    } catch (error) {
      if (Object.keys(error as object).length) {
        snackbarStore.addMessage({
          message: "Invalid file",
          type: "error",
        });
      }
    }

    const mapped: Array<T> = [];

    for (let i = 0; i < data.length; i++) {
      const row = data[i];

      progressLabel = `Preparing images for ${i + 1} row`;

      let withImageRow = row;

      if (!checkIsRequiredFilled(row)) {
        return;
      }

      if (checkIsImageRow(row)) {
        try {
          const res = await fetch(withImageRow.img);
          const mimeType = res["headers"].get("content-type") || "image/jpeg";
          const blob = await res.blob();
          const reducedBlob = await reduceImageSize(blob);
          let encodedImg = await fromBlobToUint8Array({ files: [reducedBlob] });

          const image: ImageObject = {
            id: [],
            mimeType,
            name: row.img.split("/").pop(),
            data: encodedImg[0],
          };

          withImageRow = { ...row, image: image };
        } catch (error) {
          progressLabel = `Image for ${i + 1} row was not uploaded`;

          snackbarStore.addMessage({
            message: `Unable to fetch image url in row #${i + 1}: ${withImageRow.img}`,
            type: "error",
          });
        }
      }

      progress = 5 + (10 * (i + 1)) / data.length;

      mapped.push(dataMapper(withImageRow));
    }

    await onImport(mapped);

    loading = false;

    progress = 0;

    dispatch("close");
  }

  function handleClose() {
    open = false;

    dispatch("close");
  }

  $: {
    if (!open) {
      files = [];
    }
  }
</script>

<Modal
  bind:open
  onClose={handleClose}
  className="entity-import-modal__modal-root"
>
  <div class="entity-import-modal">
    <div class="entity-import-modal__header">
      <h4 class="h4">{title}</h4>

      <button
        class="entity-import-modal__close-button"
        tabindex="-1"
        on:click={handleClose}><X size={32} /></button
      >
    </div>

    <Divider />

    <div class="entity-import-modal__content">
      <div class="entity-import-modal__images">
        <FileUploader
          bind:files
          labelTitle={"Upload file"}
          labelSubtitle={"CSV files only"}
          accept={SHEET_EXTENSIONS}
          maxFiles={1}
          hiddenCurrentSizeToUpload
          on:max-files-error={({ detail }) =>
            snackbarStore.addMessage({
              message: `You can only upload ${detail.maxFiles} file`,
              type: "error",
            })}
        />
      </div>
    </div>

    <div class="entity-import-modal__progress_wrapper">
      <div
        class="entity-import-modal__progress_text subtitle2"
        class:entity-import-modal__progress_text--hidden={!progress}
      >
        {progressLabel}
        <Progress value={progress} />
      </div>

      <Divider />

      <div class="entity-import-modal__footer">
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
  </div>
</Modal>

<style lang="scss">
  :global(.entity-import-modal__modal-root) {
    max-width: 600px;
    width: 100%;
    padding: 8px;
  }

  .entity-import-modal {
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
      width: 100%;
    }

    &__footer {
      display: flex;
      justify-content: flex-end;
      gap: 16px;
      padding: 16px;
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

    &__progress_wrapper {
      padding: 16px;
      text-align: right;
    }

    &__progress_text {
      margin-bottom: 16px;
      white-space: pre;
      opacity: 1;
      transition: opacity var(--uni-transition-default);

      &--hidden {
        opacity: 0;
      }
    }
  }
</style>
