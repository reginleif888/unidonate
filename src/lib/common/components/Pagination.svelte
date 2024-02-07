<script lang="ts">
  import { Pagination } from "bits-ui";
  import { CaretLeft, CaretRight } from "phosphor-svelte";

  export let currentPage: number = 1;
  export let perPage: number = 10;
  export let count: number = 0;
</script>

<Pagination.Root
  bind:page={currentPage}
  {count}
  {perPage}
  siblingCount={0}
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
  <p class="subtitle2">
    Showing {range.start} - {range.end}
  </p>
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
    gap: 4px;
    margin-bottom: 8px;
  }

  :global(.pagination-button) {
    display: inline-flex;
    font-size: 10px;
    align-items: center;
    justify-content: center;
    border-radius: var(--button-border-radius);
    border: 1px solid var(--divider-color);
    background-color: var(--brand-secondary-color);
    height: var(--button-height-small);
    width: var(--button-height-small);
    color: var(--opposite-text);
    cursor: pointer;
    transition: all var(--transition-default);
  }

  :global(.pagination-button:hover) {
    background-color: var(--secondary-button-contained-hover-bg);
  }

  :global(.current-page.current-page) {
    background-color: var(--brand-primary-color);
    color: var(--opposite-text);
  }

  :global(.current-page.current-page.current-page:hover) {
    background-color: var(--primary-button-contained-hover-bg);
    color: var(--primary-button-contained-hover-color);
  }

  :global(.pagination-button:disabled path) {
    fill: var(--button-disabled-color);
    transition: all var(--transition-default);
  }
  :global(.pagination-button:disabled) {
    background: var(--button-disabled-bg);
    cursor: default;
  }

  :global(.pagination-button path) {
    fill: var(--opposite-text);
  }

  :global(.pages-container) {
    display: flex;
    align-items: center;
    gap: 2.5px;
    color: var(--divider-color);
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
    border-radius: var(--button-border-radius);
    background-color: transparent;
    height: var(--button-height-small);
    width: var(--button-height-small);
    cursor: pointer;
    border: 1px solid var(--divider-color);
    color: var(--divider-color);
  }

  :global(.pagination-page:hover) {
    background-color: var(--primary-button-hover-bg);
  }
</style>
