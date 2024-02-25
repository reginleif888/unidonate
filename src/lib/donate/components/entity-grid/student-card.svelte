<script lang="ts">
  import { Button, Swiper } from "$lib/common/components";
  import { formatDateValueToLocale } from "$lib/common/utils";
  import type { FormStudent } from "$lib/donate/types";
  import { parseDate } from "@internationalized/date";

  export let selected: boolean = false;
  export let item: FormStudent;
  export let onSelect: (item: FormStudent) => void = () => null;

  const handleSelect = () => {
    onSelect(item);
  };
</script>

<div class="card-root">
  <div class="swiper-wrapper">
    <Swiper items={item.imgs} let:item={img}>
      <img src={img || "/images/no-image.jpg"} alt="school" />
    </Swiper>
  </div>
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
      <span>{formatDateValueToLocale(parseDate(item.dateOfBirth))}</span>
    </div>
    <div>
      <b class="attribute-label">Grade:</b>
      <span>{item.grade}</span>
    </div>
  </div>
  <Button
    label={selected ? "Unselect" : "Select"}
    contained={selected}
    on:click={handleSelect}
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

  .swiper-wrapper {
    width: 100%;
    height: 200px;
  }
</style>
