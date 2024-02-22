<script lang="ts">
  import { createEventDispatcher } from "svelte";
  import Tooltip from "./tooltip.svelte";
  import { truncateFileName } from "../utils";
  import { X } from "phosphor-svelte";
  import type { UploadedFile } from "../types";

  export let maxSize: number = 0;
  export let maxTotalSize: number = 0;
  export let multiple: boolean = true;
  export let labelTitle: string = "Upload files";
  export let labelSubtitle: string = "";
  export let buttonLabel: string = "Add files";
  export let accept: Array<string> = [];
  export let files: Array<File | UploadedFile> = [];
  export let maxFiles: number = 0;

  const dispatch = createEventDispatcher();

  let fileInput: HTMLInputElement | null = null;

  function handleClick(event: MouseEvent) {
    const target = event.target as HTMLInputElement | null;

    if (target) {
      target.value = "";
    }
  }

  $: sizeToUpload = (
    [...files.filter((file) => (file as File).size)] as unknown as Array<File>
  ).reduce((acc, file: File) => acc + file.size, 0);

  function handleChange(event: Event) {
    const target = event.target as HTMLInputElement | null;

    if (target) {
      const localFiles = [...(target.files ?? [])];

      let sizeError = localFiles.some((file) => file.size > maxSize);

      let totalSizeError =
        (
          [
            ...localFiles,
            ...files.filter((file) => (file as File).size),
          ] as unknown as Array<File>
        ).reduce((acc, file: File) => acc + file.size, 0) >= maxTotalSize;

      if (maxTotalSize && totalSizeError) {
        dispatch("total-size-error", { maxTotalSize });

        return;
      }

      if (maxFiles && files.length + localFiles.length > maxFiles) {
        dispatch("max-files-error", { maxFiles });

        return;
      }

      if (maxSize && sizeError) {
        dispatch("size-error", { maxSize });

        return;
      }

      if (multiple) {
        files = [
          ...files.filter((file) =>
            localFiles.find((f) => f.name !== file.name)
          ),
          ...localFiles,
        ];
      } else {
        files = [...localFiles];
      }

      dispatch("change", files);
    }
  }

  function handleButtonClick() {
    if (fileInput) {
      fileInput.click();
    }
  }
</script>

<div class="file-uploader">
  <label class="file-uploader__label overline" for="file-input"
    >{labelTitle}</label
  >

  <span class="caption">{labelSubtitle}</span>

  <span class="caption"
    >Current total size to upload: {Number(sizeToUpload / 1024 / 1024).toFixed(
      2
    )}MB</span
  >

  <button
    type="button"
    class="file-uploader__button"
    tabindex="-1"
    id="file-input"
    on:click={handleButtonClick}
  >
    {buttonLabel}
  </button>

  <div class="file-uploader__files">
    {#each files as file (file.name)}
      <div class="file-uploader__file-container">
        <Tooltip
          disabled={!truncateFileName({ file: file.name, maxLength: 15 })
            .truncated}
        >
          <div slot="trigger" class="file-uploader__file">
            {truncateFileName({ file: file.name, maxLength: 15 }).name}
          </div>

          <div slot="content">
            {file.name}
          </div>
        </Tooltip>
        <button
          class="file-uploader__delete-button"
          on:click={() => {
            files = files.filter((f) => f.name !== file.name);

            dispatch("change", files);
          }}
        >
          <X size={16} />
        </button>
      </div>
    {/each}
  </div>

  <input
    type="file"
    tabindex="-1"
    accept={accept.join(", ")}
    bind:this={fileInput}
    on:change|stopPropagation={handleChange}
    on:click
    on:click={handleClick}
    class="file-uploader__hidden-input"
  />
</div>

<style lang="scss">
  .file-uploader {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;

    &__button {
      padding: 8px 16px;
      border-radius: 8px;
      background-color: var(--uni-primary);
      color: var(--uni-on-primary);
      border: none;
      cursor: pointer;
    }

    &__file {
      border-radius: unset;
      border: unset;
      background-color: transparent;
      color: var(--uni-on-bg);
    }

    &__file-container {
      display: flex;
      align-items: center;
      border-radius: 8px;
      border: 1px solid var(--uni-divider-color);
      padding: 8px 16px;
    }

    &__delete-button {
      background-color: var(--uni-bg-transparent-300);
      padding: 0;
      border: unset;
      cursor: pointer;
      background-color: transparent;
      color: var(--uni-on-bg);
      position: relative;
      top: 3px;
      margin-left: 8px;
    }

    &__hidden-input {
      display: none;
    }

    &__files {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
    }

    &__label {
      font-weight: bold;
    }
  }
</style>
