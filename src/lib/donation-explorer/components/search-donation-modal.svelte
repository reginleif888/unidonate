<script lang="ts">
  import { flyAndScale } from "$lib/common/transitions";
  import { Input, Modal, Spinner } from "$lib/common/components";
  import Button from "$lib/common/components/button.svelte";
  import { MagnifyingGlass } from "phosphor-svelte";
  import { wait } from "$lib/common/utils";

  export let open: boolean = true;

  export let search: string = "";

  let donationFound: boolean = false;

  let loading: boolean = false;

  async function handleSearchExecute() {
    loading = true;

    donationFound = false;

    await wait(3000);

    loading = false;

    donationFound = true;
  }

  $: {
    if (open) {
      donationFound = false;
      search = "";
    }
  }
</script>

<Modal bind:open align="start">
  <div class="search-donation-modal">
    <div class="search-donation-modal__input-wrapper">
      <Input placeholder="Search for donation...">
        <span slot="end-icon">
          <Button
            label="Search"
            size="small"
            contained
            on:click={handleSearchExecute}
          >
            <div
              slot="start-icon"
              class:search-donation-modal__search-icon={!loading}
            >
              {#if !loading}
                <MagnifyingGlass size={20} />
              {/if}

              {#if loading}
                <Spinner size={20} />
              {/if}
            </div>
          </Button>
        </span>
      </Input>
    </div>

    {#if donationFound}
      <div
        transition:flyAndScale
        class="search-donation-modal__found-placeholder subtitle2"
      >
        Donation was found found click
        <a
          href="https://github.com/reginleif888/unidonate"
          target="_blank"
          rel="noopener noreferrer"
          class="search-donation-modal__search-link"
        >
          here
        </a> to explore 🎉
      </div>
    {/if}

    <!-- <div class="search-donation-modal__found-placeholder subtitle2">
      Following donation was not found... 😔
    </div> -->
  </div>
</Modal>

<style lang="scss">
  .search-donation-modal {
    width: 900px;
    border-radius: var(--uni-radius-input);
    color: var(--uni-on-bg);
    position: relative;

    &__input-wrapper {
      width: 100%;
      margin-bottom: 16px;
    }

    &__search-icon {
      position: relative;
      top: 2px;
    }

    &__search-link {
      color: var(--uni-primary);
    }

    &__found-placeholder {
      padding: 16px;
      color: var(--uni-on-bg);
      background-color: var(--uni-bg);
      border-radius: 8px;
      border: 1px solid var(--uni-divider-color);
      box-shadow: var(--uni-shadow-paper);
      position: absolute;
      width: 100%;
    }
  }
</style>
