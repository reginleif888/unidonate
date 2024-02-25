<script lang="ts">
  import {
    Button,
    Input,
    Pagination,
    InputWithLabel,
    Select,
    Only,
  } from "$lib/common/components";
  import { EntityGrid, SchoolCard, StudentCard } from "$lib/donate/components";
  import * as Icons from "phosphor-svelte";
  import {
    type FormStudent,
    type FormSchool,
    EntityType,
    type EntityTypeValue,
    type PaginationFilter,
  } from "../types";
  import { PAGE_SIZES_SELECT_ITEMS } from "../constant";
  import { debounce } from "$lib/common/utils";
  import { screenWidthStore } from "$lib/common/stores";
  import { SCREEN } from "$lib/common/constant";

  export let data: Array<FormStudent> | Array<FormSchool> = [];

  export let total: number = 0;

  export let filter: PaginationFilter = {
    search: "",
    page: 1,
    perPage:
      $screenWidthStore < SCREEN.desktop
        ? Number(PAGE_SIZES_SELECT_ITEMS[0].value)
        : Number(PAGE_SIZES_SELECT_ITEMS[3].value),
  };

  export let entityType: EntityType = EntityType.School;

  export let selected: string | null = null;

  export let loading: boolean = false;

  export let noStudents: boolean = false;

  export let onStudentSelect: () => void = () => null;

  export let onDirectDonate: () => void = () => null;

  export let onSelect: (selected: string | null) => void = () => null;

  const mapEntityType: Record<EntityType, EntityTypeValue> = {
    [EntityType.School]: {
      title: "Select school",
      subtitle: "Select a school to donate to",
      searchPlaceholder: "My school...",
      Component: SchoolCard,
    },
    [EntityType.Student]: {
      title: "Select student",
      subtitle: "Select a student to donate to",
      searchPlaceholder: "My student...",
      Component: StudentCard,
    },
  };

  let search = "";

  let perPage =
    $screenWidthStore < SCREEN.desktop
      ? PAGE_SIZES_SELECT_ITEMS[0]
      : PAGE_SIZES_SELECT_ITEMS[3];

  let page: number = 1;

  let scrollRoot: HTMLElement;

  let headingRoot: HTMLElement;

  let stickyTopControls: boolean = false;

  let prevScrollTop: number = 0;

  let isScrollingBottom: boolean = false;

  function handlePageReset() {
    page = 1;
  }

  function checkStickyTopControls() {
    if (scrollRoot) {
      const scrollTop = Math.max(scrollRoot.scrollTop, 0);

      stickyTopControls = scrollTop > headingRoot.clientHeight + 48;

      isScrollingBottom = scrollTop > prevScrollTop;

      prevScrollTop = scrollTop;
    }
  }

  filter = {
    search,
    page,
    perPage: Number(perPage.value),
  };

  const [debounced] = debounce(() => {
    if ($screenWidthStore < SCREEN.desktop) {
      scrollRoot.scrollTop = 0;
    }

    filter = {
      search,
      page,
      perPage: Number(perPage.value),
    };
  }, 500);

  $: [search, page, perPage], debounced();
</script>

<div class="root" bind:this={scrollRoot} on:scroll={checkStickyTopControls}>
  <div class="main-section">
    <div bind:this={headingRoot} class="heading-section">
      <h4 class="h4 step-heading">{mapEntityType[entityType].title}</h4>
      <div class="body1 step-description">
        {mapEntityType[entityType].subtitle}
      </div>
    </div>
    <div
      class="top-controls-wrapper"
      class:top-controls-wrapper--scrolling={stickyTopControls}
      class:top-controls-wrapper--scrolling-bottom={isScrollingBottom}
    >
      <div class="search-wrapper">
        <InputWithLabel label="Search">
          <Input
            placeholder={mapEntityType[entityType].searchPlaceholder}
            on:input={handlePageReset}
            bind:value={search}
            size={$screenWidthStore >= SCREEN.desktop ? "medium" : "small"}
          >
            <span slot="end-icon">
              <Icons.MagnifyingGlass size={20} />
            </span>
          </Input>
        </InputWithLabel>
      </div>
    </div>
    <div class="grid-wrapper">
      <EntityGrid
        {data}
        perPage={Number(perPage.value)}
        bind:selected
        {onSelect}
        {loading}
        Entity={mapEntityType[entityType].Component}
        {entityType}
      />
    </div>
  </div>
  <div class="controls-section-bottom">
    <div class="pagination-wrapper">
      <div class="select-wrapper">
        <InputWithLabel label="Per page">
          <Select
            items={PAGE_SIZES_SELECT_ITEMS}
            bind:selected={perPage}
            on:change={handlePageReset}
            size={$screenWidthStore >= SCREEN.desktop ? "medium" : "small"}
          />
        </InputWithLabel>
      </div>
      <div>
        {#if Number(total) > Number(perPage.value)}
          <Pagination
            count={Number(total)}
            bind:currentPage={page}
            perPage={Number(perPage.value)}
            mobile={$screenWidthStore < SCREEN.desktop}
          />
        {/if}
      </div>
    </div>

    <Only from="desktop">
      {#if entityType === EntityType.School}
        <div
          class="controls-section-buttons"
          class:controls-section-buttons--selected={selected}
        >
          <Button
            label="Donate"
            contained
            variant="secondary"
            on:click={onDirectDonate}
          />

          {#if !noStudents}
            <span class="body1">Or</span>
            <Button
              label="Select student"
              contained
              on:click={onStudentSelect}
            />
          {/if}
        </div>
      {/if}

      {#if entityType === EntityType.Student}
        <div
          class="controls-section-buttons"
          class:controls-section-buttons--selected={selected}
        >
          <Button
            label="Allocate donation"
            contained
            on:click={onDirectDonate}
          />
        </div>
      {/if}
    </Only>

    {#if selected}
      <Only to="desktop">
        <div class="mobile-buttons">
          {#if entityType === EntityType.School}
            <Button
              label="Donate"
              contained
              variant="secondary"
              fullWidth
              justify="center"
              on:click={onDirectDonate}
            />
            {#if !noStudents}
              <Button
                label="Select student"
                contained
                fullWidth
                justify="center"
                on:click={onStudentSelect}
              />
            {/if}
          {/if}

          {#if entityType === EntityType.Student}
            <Button
              label="Donate"
              contained
              fullWidth
              justify="center"
              on:click={onDirectDonate}
            />
          {/if}
        </div>
      </Only>
    {/if}
  </div>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .root {
    display: flex;
    flex-direction: column;
    background-color: var(--uni-bg-transparent-700);
    box-shadow: var(--uni-shadow-paper);
    width: 100%;
    height: 100%;
    overflow: scroll;
  }

  .step-heading {
    margin-bottom: 8px;
  }

  .step-description {
    margin-bottom: 4px;

    @include respond-to("desktop") {
      margin-bottom: 24px;
    }
  }

  .heading-section {
    padding-bottom: 0px;
    padding: 8px;

    @include respond-to("desktop") {
      padding: 16px;
    }
  }

  .grid-wrapper {
    padding: 0 8px;
    padding-bottom: 8px;

    @include respond-to("desktop") {
      padding: 0 16px;
      padding-bottom: 16px;
    }
  }

  .mobile-buttons {
    width: 100%;
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    gap: 8px;
  }

  .top-controls-wrapper {
    width: 100;
    position: sticky;
    top: 0;
    transition: all var(--uni-transition-default);
    padding: 0 8px;
    margin-bottom: 16px;

    display: flex;
    justify-content: space-between;
    align-items: flex-end;

    @include respond-to("desktop") {
      padding: 0 16px;
      margin-bottom: 24px;
    }

    &--scrolling {
      background-color: var(--uni-bg);
      box-shadow: var(--uni-shadow-paper);
      z-index: 1;
      padding: 8px;

      @include respond-to("desktop") {
        padding: 16px;
      }
    }

    &--scrolling-bottom {
      opacity: 0;
      pointer-events: none;

      @include respond-to("desktop") {
        opacity: 1;
        pointer-events: all;
      }
    }
  }

  .main-section {
    flex-grow: 1;
  }

  .controls-section-bottom {
    bottom: 0;
    position: sticky;
    background-color: var(--uni-bg);
    padding: 8px;
    border-top: 1px solid var(--uni-primary-transparent-70);
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    flex-direction: column;

    @include respond-to("desktop") {
      padding: 16px;
      flex-direction: row;
    }
  }

  .controls-section-buttons {
    display: flex;
    gap: 16px;
    align-items: center;
    justify-content: flex-end;
    opacity: 0;
    pointer-events: none;
    transition: all var(--uni-transition-default);
    max-width: 600px;
    width: 100%;
    &--selected {
      pointer-events: all;
      opacity: 1;
    }
  }

  .search-wrapper {
    width: 100%;

    @include respond-to("desktop") {
      max-width: 300px;
      width: 100%;
    }
  }

  .select-wrapper {
    max-width: 120px;
    width: 100%;
  }

  .pagination-wrapper {
    display: flex;
    align-items: flex-end;
    gap: 8px;
    width: 100%;
    justify-content: space-between;

    @include respond-to("desktop") {
      justify-content: flex-start;
    }
  }
</style>
