<script lang="ts">
  import { Button } from "$lib/common/components";
  import type { FormSchool } from "$lib/donate/types";
  import { fade } from "svelte/transition";

  export let selected: boolean = false;
  export let item: FormSchool;
  export let onSelect: (uni: FormSchool) => void = () => null;

  const handleSelect = () => {
    onSelect(item);
  };
</script>

<div class="card-root" transition:fade>
  <img src="images/harvard.webp" alt="school" />
  <a href={item.website} target="_blank" class="website-badge overline"
    >Website</a
  >
  <div class="description body2">
    <div class="school-name">
      <b class="attribute-label">Name:</b>
      <span>{item.name}</span>
    </div>
    <div>
      <b class="attribute-label">Location:</b>
      <span>{item.location}</span>
    </div>
    <div>
      <b class="attribute-label">Number of students:</b>
      <span>{item.numberOfStudents}</span>
    </div>
  </div>
  <Button
    label={selected ? "Unselect" : "Select"}
    contained={selected}
    on:click={handleSelect}
  />
</div>

<style lang="scss">
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
    position: relative;
  }

  .description {
    display: flex;
    flex-direction: column;
    gap: 8px;
    flex-grow: 1;
  }

  .website-badge {
    position: absolute;
    top: 190px;
    left: 6px;
    display: block;
    background: var(--uni-primary-contained-button-default-bg);
    color: var(--uni-on-primary);
    text-decoration: none;
    padding: 8px;
    border-radius: 4px;

    &:hover {
      background: var(--uni-primary-contained-button-hover-bg);
    }
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
