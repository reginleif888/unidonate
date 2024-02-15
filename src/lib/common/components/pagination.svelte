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
  class="pagination-root"
>
  <div class="inner">
    <Pagination.PrevButton class="pagination-button">
      <CaretLeft size={16} />
    </Pagination.PrevButton>
    <div class="pages-container">
      {#each pages as page (page.key)}
        {#if page.type === "ellipsis"}
          <div class="pagination-ellipsis">...</div>
        {:else}
          <Pagination.Page
            {page}
            class={`pagination-page subtitle1 ${String(currentPage) === String(page.value) ? "current-page" : ""}`}
          >
            {page.value}
          </Pagination.Page>
        {/if}
      {/each}
    </div>
    <Pagination.NextButton class="pagination-button">
      <CaretRight size={16} />
    </Pagination.NextButton>
  </div>
  {#if showingHidden}
    <p class="subtitle2">
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

  :global(.inner) {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;
    margin-bottom: 8px;
  }

  :global(.pagination-button) {
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
    transition: all var(--transition-default);
  }

  :global(.pagination-button:hover) {
    background: var(--uni-secondary-contained-button-hover-bg);
    color: var(--uni-secondary-contained-button-hover-color);
    border: 1px solid var(--uni-secondary-contained-button-hover-border);
  }

  :global(.current-page.current-page) {
    background: var(--uni-primary-contained-button-default-bg);
    color: var(--uni-primary-contained-button-default-color);
    border: 1px solid var(--uni-primary-contained-button-default-border);
  }

  :global(.current-page.current-page.current-page:hover) {
    background: var(--uni-primary-contained-button-hover-bg);
    color: var(--uni-primary-contained-button-hover-color);
    border: 1px solid var(--uni-primary-contained-button-hover-border);
  }

  :global(.pagination-button:disabled) {
    background: var(--uni-secondary-contained-button-disabled-bg);
    color: var(--uni-secondary-contained-button-disabled-color);
    border: 1px solid var(--uni-secondary-contained-button-disabled-border);
    cursor: default;
  }

  :global(.pages-container) {
    display: flex;
    align-items: center;
    gap: 4px;
    color: var(--uni-on-bg);
  }

  :global(.pagination-ellipsis) {
    display: flex;
    align-items: center;
    justify-content: center;
  }

  :global(.pagination-page) {
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

  :global(.pagination-page:hover) {
    background-color: var(--primary-button-hover-bg);
  }
</style>
