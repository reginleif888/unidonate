<script lang="ts">
  import { flyAndScale } from "$lib/common/transitions";
  import { Input, Modal, Spinner } from "$lib/common/components";
  import Button from "$lib/common/components/button.svelte";
  import { MagnifyingGlass } from "phosphor-svelte";
  import { useGetDonationByIdMutation } from "../queries";
  import type { Donation } from "../../../declarations/backend/backend.did";
  import { AppRoute } from "$lib/common/routes";

  export let open: boolean = true;

  export let search: string = "";

  let loading: boolean = false;

  let searchExecuted: boolean = false;

  let donation: Donation | null = null;

  const getDonationById = useGetDonationByIdMutation();

  function handleDonationReset() {
    searchExecuted = false;
    donation = null;
  }

  async function handleSearchExecute() {
    if (!search) {
      return;
    }

    searchExecuted = true;

    donation = null;

    try {
      loading = true;

      donation = await $getDonationById.mutateAsync({ donationId: search });
    } catch (error) {
      console.error(error);

      donation = null;
    } finally {
      loading = false;
    }

    loading = false;
  }

  $: {
    if (open) {
      search = "";
    }
  }
</script>

<Modal bind:open align="start" className="search-donation-modal-root">
  <div class="search-donation-modal">
    <div class="search-donation-modal__input-wrapper">
      <Input
        placeholder="Your donation id..."
        on:input={handleDonationReset}
        bind:value={search}
      >
        <span slot="end-icon">
          <Button
            label="Search"
            size="small"
            contained
            on:click={handleSearchExecute}
            notClickable={loading}
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

    {#if searchExecuted && donation}
      <div
        transition:flyAndScale
        class="search-donation-modal__found-placeholder subtitle2"
      >
        Donation was found found click
        <a
          href={`${AppRoute.Explorer}/${donation.donationId}`}
          target="_blank"
          rel="noopener noreferrer"
          class="search-donation-modal__search-link"
        >
          here
        </a> to explore 🎉
      </div>
    {/if}

    {#if searchExecuted && !donation}
      <div
        transition:flyAndScale
        class="search-donation-modal__found-placeholder subtitle2"
      >
        Donation with id "{search}" was not found... 😔
      </div>
    {/if}
  </div>
</Modal>

<style lang="scss">
  :global(.search-donation-modal-root) {
    max-width: 900px;
    width: 100%;
    padding: 0 8px;
  }

  .search-donation-modal {
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
