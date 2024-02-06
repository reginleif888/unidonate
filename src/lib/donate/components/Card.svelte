<script lang="ts">
  import type { GridItem } from "$lib/donate/types";

  export let selected: boolean = false;
  export let item: GridItem;
  export let onClick: (id: GridItem) => void = () => null;
</script>

<button class="root" class:selected on:click={() => onClick(item)}>
  <div class="item__img-container">
    <img src={item.image} alt="card-item" />
  </div>
  <div class="item__description">
    <div class="item__name subtitle2">{item.name}</div>
    <div class="item__value subtitle1">{item.description}</div>
  </div>
</button>

<style lang="scss">
  .root {
    display: flex;
    flex-direction: column;

    gap: 0.5rem;
    border: 1px solid var(--divider-color);
    background-color: var(--primary-bg);

    cursor: pointer;
    transition: var(--transition-default);

    &:hover {
      background-color: var(--secondary-button-hover-bg);
      box-shadow: (--shadow-card);
    }
  }

  .selected {
    background-color: var(--secondary-button-hover-bg);
    border-color: var(--brand-secondary-color);
  }

  .item__img-container {
    width: 100%;
    height: 50px;
  }

  img {
    width: 100%;
    object-fit: cover;
  }

  .item__description {
    display: flex;
    flex-direction: column;
    padding: 8px;
    gap: 8px;
  }
</style>
