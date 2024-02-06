<script>
  import Pagination from "$lib/common/components/Pagination.svelte";
  import Spinner from "$lib/common/components/Spinner.svelte";
  import TextInput from "$lib/common/components/TextInput.svelte";
  import { MagnifyingGlass } from "phosphor-svelte";
  import { schools } from "../mocks";
  import { mapSchoolsToGridItems } from "../utils";

  import CardGrid from "./CardGrid.svelte";
</script>

<div class="root">
  <div class="text-input-wrapper">
    <TextInput placeholder="Search..." label="Search for student">
      <svelte:fragment slot="end-icon">
        <MagnifyingGlass size={24} />
      </svelte:fragment>
    </TextInput>
  </div>
  <div class="grid-wrapper">
    <CardGrid items={mapSchoolsToGridItems(schools).slice(1, 3)} value={"4"} />
    <!-- <Spinner /> -->
  </div>

  <div class="pagination-wrapper"><Pagination /></div>
</div>

<style>
  .pagination-wrapper {
    display: flex;
    justify-content: center;
    margin-top: 20px;
  }

  .text-input-wrapper {
    margin-bottom: 20px;
  }

  .grid-wrapper {
    margin-bottom: 20px;
    position: relative;
  }
</style>
