<script>
  import { Button } from "$lib/common/components";
  import { HandHeart } from "phosphor-svelte";
</script>

<div class="logos-wrapper">
  <h1 class="h1 first-main-label">Next generation</h1>
  <h1 class="h1 second-main-label">Donation Platform</h1>
</div>
<p class="body1 home-description">
  Make you donation for education 100% on-chain on the world’s fastest and most
  powerful open‑source blockchain network: the Internet Computer
</p>
<div class="donate-button-wrapper">
  <Button label="Donate for education" contained>
    <span slot="end-icon" class="hand-heart-icon">
      <HandHeart size={20} />
    </span>
  </Button>
</div>

<style lang="scss">
  .donate-button-wrapper {
    width: 100%;
    display: flex;
    justify-content: center;
    margin-top: 16px;
  }

  .logos-wrapper {
    width: 100%;
  }

  .first-main-label {
    color: var(--uni-primary);
    width: 100%;
    text-align: center;
  }

  .second-main-label {
    width: 100%;
    text-align: center;
  }

  .home-description {
    color: var(--uni-text-color-300);
    text-align: center;
  }

  .hand-heart-icon {
    margin-left: 8px;
    position: relative;
    top: 2px;
  }
</style>
