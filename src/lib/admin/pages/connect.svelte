<script lang="ts">
  import { Button, LockAnimatedIcon, Spinner } from "$lib/common/components";
  import { ConnectedNavCards } from "$lib/admin/components";
  import { authClientStore, isAdminStore } from "$lib/common/stores";
  import { AuthClient } from "@dfinity/auth-client";

  async function connect() {
    if ($authClientStore) {
      const isAuth = await $authClientStore?.isAuthenticated();

      if (isAuth) {
        $authClientStore.logout();

        /**
         *
         * recreate the authClientStore to force rerender on the top level
         */
        $authClientStore = await AuthClient.create();

        return;
      }

      $authClientStore.login({
        maxTimeToLive: BigInt(24 * 60 * 60 * 1000 * 1000 * 1000),
        identityProvider:
          process.env.DFX_NETWORK === "ic"
            ? "https://identity.ic0.app/#authorize"
            : `http://${process.env.CANISTER_ID_INTERNET_IDENTITY}.localhost:4943/#authorize`,
        windowOpenerFeatures:
          `left=${window.screen.width / 2 - 525 / 2}, ` +
          `top=${window.screen.height / 2 - 705 / 2},` +
          `toolbar=0,location=0,menubar=0,width=525,height=705`,
        onSuccess: () => {
          authClientStore.update((stored) => stored);
        },
        onError: (err) => {
          console.error(err);
        },
      });
    }
  }
</script>

<div class="root">
  <div class="heading" class:heading-connected={true}>
    {#await $isAdminStore}
      <Spinner size={150} />
    {:then isAdmin}
      <LockAnimatedIcon color="var(--uni-on-primary)" unlocked={isAdmin} />
    {/await}

    <h1 class="h1">Uni Admin</h1>
    <p class="body1 heading-description">
      Manage your schools and students with unparalleled ease and efficiency.
    </p>

    <p class="body1 heading-description">
      Your principal: {$authClientStore?.getIdentity().getPrincipal().toText()}
    </p>
  </div>

  {#await Promise.all( [$authClientStore?.isAuthenticated(), $isAdminStore] ) then [isAuth, isAdmin]}
    {#if isAuth && !isAdmin}
      <p class="body1">You are not admin</p>
    {/if}
  {/await}

  <div class="fake-buttons">
    {#await Promise.all( [$authClientStore?.isAuthenticated(), $isAdminStore] ) then [_, isAdmin]}
      {#if isAdmin}
        <div class="connected-buttons-wrapper">
          <ConnectedNavCards />
        </div>
      {/if}
    {/await}
  </div>

  <div class="inner">
    <div class="connect-button">
      {#await $authClientStore?.isAuthenticated()}
        <Button
          label={"Loading..."}
          variant="secondary"
          justify="center"
          contained
          fullWidth
          notClickable
        />
      {:then isAuth}
        <Button
          label={isAuth ? "Disconnect" : "Connect"}
          variant="secondary"
          justify="center"
          contained
          fullWidth
          on:click={connect}
        />
      {/await}
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
    top: 24%;
    padding: 0 8px;

    @include respond-to("smallTablet") {
      top: 26%;
    }
  }

  .heading-description {
    text-align: center;
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
