<script lang="ts">
  import { Button } from "$lib/common/components";
  import type { FormStudent } from "$lib/donate/types";
  import { fade } from "svelte/transition";

  export let selected: boolean = false;
  export let item: FormStudent;
  export let onSelect: (item: FormStudent) => void = () => null;

  let imgSrc = item.img;

  const handleImgError = () => {
    imgSrc = "images/no-image.jpg";
  };

  const handleSelect = () => {
    onSelect(item);
  };
</script>

<div class="card-root" transition:fade>
  <img src={imgSrc} alt="student" on:error={handleImgError} />
  <div class="description body2">
    <div>
      <b class="attribute-label">First name:</b>
      <span>{item.firstName}</span>
    </div>
    <div>
      <b class="attribute-label">Last name:</b>
      <span>{item.lastName}</span>
    </div>
    <div>
      <b class="attribute-label">Date of birth:</b>
      <span>{item.dateOfBirth}</span>
    </div>
    <div>
      <b class="attribute-label">Grade:</b>
      <span>{item.grade}</span>
    </div>
  </div>
  <Button
    label={selected ? "Selected" : "Select"}
    contained={selected}
    onClick={handleSelect}
  />
</div>

<style>
  .card-root {
    display: flex;
    flex-direction: column;
    gap: 16px;
    padding: 16px;
    min-height: 400px;
    border: 1px solid var(--uni-divider);
    border-radius: 24px;
    background: var(--uni-bg);
    box-shadow: var(--uni-shadow-paper);
  }

  .description {
    display: flex;
    flex-direction: column;
    gap: 8px;
    flex-grow: 1;
  }

  .attribute-label {
    font-weight: 700;
  }

  img {
    width: 100%;
    height: 200px;
    object-fit: cover;
    border-radius: 16px;
    background-color: var(--uni-secondary);
  }
</style>
