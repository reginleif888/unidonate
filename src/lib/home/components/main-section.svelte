<script>
  import { goto } from "$app/navigation";
  import { Button } from "$lib/common/components";
  import { AppRoute } from "$lib/common/routes";
  import { HandHeart } from "phosphor-svelte";
</script>

<div class="root">
  <div class="left-part">
    <div class="logos-wrapper">
      <h1 class="h1 first-main-label">Next generation</h1>
      <h1 class="h1 second-main-label">Donation Platform</h1>
    </div>
    <p class="body1 home-description">
      Unlock the potential of educational public donations with 100% on-chain
      donation platform powered by the Internet Computer
    </p>
    <div class="donate-button-wrapper">
      <Button
        label="Donate for education"
        contained
        on:click={() => {
          goto(AppRoute.Donate);
        }}
      >
        <span slot="end-icon" class="hand-heart-icon">
          <HandHeart size={20} />
        </span>
      </Button>
    </div>
  </div>
  <div class="right-part">
    <img src="/images/space-guy.webp" alt="space-guy" class="space-guy-1" />
  </div>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .root {
    display: flex;
  }

  .left-part {
    width: 100%;

    @include respond-to("desktop") {
      width: 50%;
    }
  }

  .right-part {
    display: none;
    position: relative;

    @include respond-to("desktop") {
      display: block;
      width: 50%;
      height: 100%;
    }
  }

  .space-guy-1 {
    position: absolute;
    right: 0px;
    top: -40px;

    @include respond-to("largeDesktop") {
      right: -100px;
    }
  }

  .donate-button-wrapper {
    width: 100%;
    display: flex;
    justify-content: center;
    margin-top: 16px;

    @include respond-to("desktop") {
      justify-content: flex-start;
    }
  }

  .logos-wrapper {
    width: 100%;
  }

  .first-main-label {
    color: var(--uni-primary);
    width: 100%;
    text-align: center;

    @include respond-to("desktop") {
      text-align: left;
    }
  }

  .second-main-label {
    width: 100%;
    text-align: center;

    @include respond-to("desktop") {
      text-align: left;
    }
  }

  .home-description {
    color: var(--uni-text-color-300);
    text-align: center;

    @include respond-to("desktop") {
      text-align: left;
    }
  }

  .hand-heart-icon {
    margin-left: 8px;
    position: relative;
    top: 2px;
  }
</style>
