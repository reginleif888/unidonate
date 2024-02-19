<script>
  import { Button, LockAnimatedIcon } from "$lib/common/components";
  import { ConnectedNavCards } from "$lib/admin/components";

  let connected = true;
</script>

<div class="root">
  <div class="heading" class:heading-connected={connected}>
    <LockAnimatedIcon color="var(--uni-on-primary)" unlocked={connected} />
    <h1 class="h1">Uni Admin</h1>
    <p class="body1 heading-description">
      Manage your schools and students with unparalleled ease and efficiency.
    </p>
  </div>

  <div class="fake-buttons">
    {#if connected}
      <div class="connected-buttons-wrapper">
        <ConnectedNavCards />
      </div>
    {/if}
  </div>

  <div class="inner">
    <div class="connect-button">
      <Button
        label={connected ? "Disconnect" : "Connect"}
        variant="secondary"
        justify="center"
        contained
        fullWidth
        on:click={() => {
          connected = !connected;
        }}
      />
    </div>
  </div>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  .root {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100%;
    gap: 16px;
    z-index: 21;
    color: var(--uni-on-primary);
    position: relative;
  }

  .heading {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 4px;
    margin-bottom: 8px;
  }

  .heading-description {
    text-align: center;
  }

  .heading-connected {
    top: 24%;

    @include respond-to("smallTablet") {
      top: 26%;
    }
  }

  .heading-fake-space {
    height: 380px;

    @include respond-to("smallTablet") {
      height: 220px;
    }
  }

  .inner {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 24px;
    padding: 8px;
    padding-bottom: 0px;
    text-align: center;
  }

  .connect-button {
    width: 140px;
  }

  .fake-buttons {
    height: 136px;
    width: 100%;
    display: flex;
    justify-content: center;

    @include respond-to("smallTablet") {
      height: 60px;
    }
  }
</style>
