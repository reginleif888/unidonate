<script lang="ts">
  import { Button } from "$lib/common/components";
  import type { FormUni } from "$lib/donate/types";
  import { fade } from "svelte/transition";

  export let selected: boolean = false;
  export let uni: FormUni;
  export let onSelect: (uni: FormUni) => void = () => null;

  const handleSelect = () => {
    onSelect(uni);
  };
</script>

<div class="card-root">
  <img src="images/harvard.webp" alt="school/student" />
  <div class="description body2">
    <div>
      <b class="attribute-label">Name:</b>
      <span>{uni.name}</span>
    </div>
    <div>
      <b class="attribute-label">Location:</b>
      <span>{uni.location}</span>
    </div>
    <div>
      <b class="attribute-label">Number of students:</b>
      <span>{uni.numberOfStudents}</span>
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
  }
</style>
