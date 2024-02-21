<script lang="ts">
  import { Pagination } from "bits-ui";
  import { CaretLeft, CaretRight } from "phosphor-svelte";

  export let currentPage: number = 1;
  export let perPage: number = 10;
  export let count: number = 0;
  export let showingHidden: boolean = false;
</script>

<Pagination.Root
  bind:page={currentPage}
  {count}
  {perPage}
  siblingCount={1}
  let:pages
  let:range
>
  <div
    class="uni-pagination-root__inner"
    class:uni-pagination-root__inner--showing-hidden={showingHidden}
  >
    <Pagination.PrevButton class="uni-pagination-root__button">
      <CaretLeft size={16} />
    </Pagination.PrevButton>
    <div class="uni-pagination-root__pages-container">
      {#each pages as page (page.key)}
        {#if page.type === "ellipsis"}
          <div class="uni-pagination-root__ellipsis">...</div>
        {:else}
          <Pagination.Page
            {page}
            class={`uni-pagination-root__page subtitle1 ${String(currentPage) === String(page.value) ? "uni-pagination-root__current-page" : ""}`}
          >
            {page.value}
          </Pagination.Page>
        {/if}
      {/each}
    </div>
    <Pagination.NextButton class="uni-pagination-root__button">
      <CaretRight size={16} />
    </Pagination.NextButton>
  </div>
  {#if showingHidden}
    <p class="subtitle2" style="margin-top: 8px;">
      Showing {range.start + 1} - {range.end}
    </p>
  {/if}
</Pagination.Root>

<style>
  :global(.pagination-root) {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    width: fit-content;
  }

  :global(.uni-pagination-root__inner) {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
  }

  :global(.uni-pagination-root__button) {
    display: inline-flex;
    font-size: 10px;
    align-items: center;
    justify-content: center;
    border-radius: var(--uni-radius-button);
    background: var(--uni-secondary-contained-button-default-bg);
    color: var(--uni-secondary-contained-button-default-color);
    border: 1px solid var(--uni-secondary-contained-button-default-border);
    height: var(--uni-height-button-medium);
    width: var(--uni-height-button-medium);
    color: var(--uni-on-secondary);
    cursor: pointer;
    transition: all var(__transition-default);
  }

  :global(.uni-pagination-root__button:hover) {
    background: var(--uni-secondary-contained-button-hover-bg);
    color: var(--uni-secondary-contained-button-hover-color);
    border: 1px solid var(--uni-secondary-contained-button-hover-border);
  }

  :global(
      .uni-pagination-root__current-page.uni-pagination-root__current-page
    ) {
    background: var(--uni-primary-contained-button-default-bg);
    color: var(--uni-primary-contained-button-default-color);
    border: 1px solid var(--uni-primary-contained-button-default-border);
  }

  :global(
      .uni-pagination-root__current-page.uni-pagination-root__current-page.uni-pagination-root__current-page:hover
    ) {
    background: var(--uni-primary-contained-button-hover-bg);
    color: var(--uni-primary-contained-button-hover-color);
    border: 1px solid var(--uni-primary-contained-button-hover-border);
  }

  :global(.uni-pagination-root__button:disabled) {
    background: var(--uni-secondary-contained-button-disabled-bg);
    color: var(--uni-secondary-contained-button-disabled-color);
    border: 1px solid var(--uni-secondary-contained-button-disabled-border);
    cursor: default;
  }

  :global(.uni-pagination-root__pages-container) {
    display: flex;
    align-items: center;
    gap: 4px;
    color: var(--uni-on-bg);
  }

  :global(.uni-pagination-root__pagination-ellipsis) {
    display: flex;
    align-items: center;
    justify-content: center;
  }

  :global(.uni-pagination-root__page) {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border-radius: var(--uni-radius-button);
    background: var(--uni-primary-outlined-button-default-bg);
    color: var(--uni-primary-outlined-button-default-color);
    border: 1px solid var(--uni-primary-outlined-button-default-border);
    cursor: pointer;
    height: var(--uni-height-button-medium);
    min-width: var(--uni-height-button-medium);
  }

  :global(.uni-pagination-root__page:hover) {
    background-color: var(__primary-button-hover-bg);
  }
</style>
