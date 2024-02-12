<script lang="ts">
  import { Button, Divider } from "$lib/common/components";
  import { InfoCard } from "$lib/home/components";
  import { HandHeart } from "phosphor-svelte";
</script>

<svelte:head>
  <title>Vite + SvelteKit + Motoko</title>
</svelte:head>

<section class="donation-section">
  <div>
    <h1 class="h1 first-main-label">Next generation</h1>
    <h1 class="h1 second-main-label">Donation System</h1>
  </div>
  <p class="body1 home-description">
    Make you donation for education 100% on-chain on the world’s fastest and
    most powerful open‑source blockchain network: the Internet Computer
  </p>
  <div class="donate-button-wrapper">
    <Button label="Donate for education" contained>
      <span slot="end-icon" class="hand-heart-icon">
        <HandHeart size={20} />
      </span>
    </Button>
  </div>
</section>

<Divider />

<section>
  <InfoCard
    title="Serve websites from smart contracts"
    description="Interact with canister smart contracts directly from your browser just like regular websites."
  />
  <InfoCard
    title="Users don’t need tokens and wallets"
    description="The reverse gas model enables free-to-use, truly user-friendly dapps, ready for mass adoption."
  />
  <InfoCard
    title="Cheapest on-chain storage"
    description="The cost of data storage and computation is stable, it doesn't depend on token prices or block space, and novel wasm runtime allows efficient runtime execution."
  />
  <InfoCard
    title="True scaling"
    description="By adding new subnets regularly, the IC scales to an unbounded number of dapps and allows storage of unlimited data."
  />
</section>

<style lang="scss">
  section {
    display: flex;
    flex-direction: column;
    padding: 24px 8px;
    gap: 16px;
  }

  .donation-section {
    align-items: flex-start;
    gap: 16px;
  }

  .donate-button-wrapper {
    width: 100%;
    display: flex;
    justify-content: center;
    margin-top: 16px;
  }

  .first-main-label {
    color: var(--uni-primary);
  }

  .second-main-label {
    font-size: 2rem;
  }

  .home-description {
    color: var(--uni-text-color-400);
  }

  .hand-heart-icon {
    margin-left: 8px;
    position: relative;
    top: 2px;
  }
</style>
