<script lang="ts">
  import {
    Button,
    Input,
    Pagination,
    InputWithLabel,
    Select,
  } from "$lib/common/components";
  import { EntityGrid, SchoolCard, StudentCard } from "$lib/donate/components";
  import * as Icons from "phosphor-svelte";
  import {
    type FormStudent,
    type FormSchool,
    EntityType,
    type EntityTypeValue,
  } from "../types";
  import { PAGE_SIZES_SELECT_ITEMS } from "../constant";

  export let data: Array<FormStudent> | Array<FormSchool> = [];

  export let entityType: EntityType = EntityType.School;

  export let selected: string | null = null;

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

  let currentPage = 1;

  let search = "";

  let loading: boolean = false;

  let timerId: NodeJS.Timeout;

  let scrollRoot: HTMLElement;

  let headingRoot: HTMLElement;

  let stickyTopControls: boolean = false;

  function checkStickyTopControls() {
    if (scrollRoot) {
      const scrollTop = scrollRoot.scrollTop;

      stickyTopControls = scrollTop > headingRoot.clientHeight + 48;
    }
  }

  $: {
    let deps = [currentPage, search];

    if (deps) {
      clearTimeout(timerId);

      loading = true;

      timerId = setTimeout(() => {
        loading = false;
      }, 1000);
    }
  }
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
    >
      <div class="search-wrapper">
        <InputWithLabel label="Search">
          <Input
            placeholder={mapEntityType[entityType].searchPlaceholder}
            bind:value={search}
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
        perPage={11}
        bind:selected
        {onSelect}
        {loading}
        Entity={mapEntityType[entityType].Component}
        {entityType}
      />
    </div>
  </div>
  <div class="controls-section">
    <div class="pagination-wrapper">
      <div class="select-wrapper">
        <InputWithLabel label="Per page">
          <Select items={PAGE_SIZES_SELECT_ITEMS} />
        </InputWithLabel>
      </div>
      <div>
        <Pagination count={50} bind:currentPage />
      </div>
    </div>

    {#if entityType === EntityType.School}
      <div
        class="controls-section-buttons"
        class:controls-section-buttons--selected={selected}
      >
        <Button
          label="Donate directly to school"
          contained
          variant="secondary"
          on:click={onDirectDonate}
        />
        <span class="body1">Or</span>
        <Button label="Select student" contained on:click={onStudentSelect} />
      </div>
    {/if}

    {#if entityType === EntityType.Student}
      <div
        class="controls-section-buttons"
        class:controls-section-buttons--selected={selected}
      >
        <Button label="Allocate donation" contained on:click={onDirectDonate} />
      </div>
    {/if}
  </div>
</div>

<style lang="scss">
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
    margin-bottom: 24px;
  }

  .heading-section {
    padding: 16px;
    padding-bottom: 0px;
  }

  .grid-wrapper {
    padding: 0 16px;
    padding-bottom: 16px;
  }

  .top-controls-wrapper {
    margin-bottom: 24px;
    width: 100;
    position: sticky;
    top: 0;
    transition: all var(--uni-transition-default);
    padding: 0 16px;

    display: flex;
    justify-content: space-between;
    align-items: flex-end;

    &--scrolling {
      background-color: var(--uni-bg);
      box-shadow: var(--uni-shadow-paper);
      z-index: 1;
      padding: 16px;
    }
  }

  .main-section {
    flex-grow: 1;
  }

  .controls-section {
    bottom: 0;
    position: sticky;
    background-color: var(--uni-bg);
    padding: 16px;
    border-top: 1px solid var(--uni-primary-transparent-70);
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
  }

  .controls-section-buttons {
    display: flex;
    gap: 16px;
    align-items: center;
    justify-content: flex-end;
    opacity: 0;
    transition: all var(--uni-transition-default);
    max-width: 600px;
    width: 100%;
    &--selected {
      opacity: 1;
    }
  }

  .search-wrapper {
    max-width: 300px;
    width: 100%;
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
  }
</style>
