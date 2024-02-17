<script>
  import PoweredBy from "./powered-by.svelte";
  import { Button } from "$lib/common/components";
</script>

<div class="root">
  <h1 class="h1 header">Powered By</h1>

  <div><img class="ic-img" src="/icons/ic.svg" alt="Internet computer" /></div>

  <div class="body2 description">
    The Internet Computer (ICP) allows Web3 services to run 100% on-chain, being
    the only protocol on top of which developers can build and users can enjoy
    fully decentralized applications. ICP ditches corporate cloud, insecure
    bridges and expensive oracles.
  </div>

  <Button
    label="Learn more about internet computer"
    variant="secondary"
    contained
    on:click={() => {
      window.open("https://internetcomputer.org/");
    }}
  />
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .root {
    display: flex;
    flex-direction: column;
    align-items: center;
    color: var(--uni-on-primary);
  }

  .header {
    text-align: center;
  }

  .ic-img {
    width: 200px;
    height: 100px;

    @include respond-to("tablet") {
      width: 400px;
    }
  }

  .description {
    text-align: center;
    margin-bottom: 40px;
  }
</style>
