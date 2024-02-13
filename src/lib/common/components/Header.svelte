<script>
  import BurgerButton from "./BurgerButton.svelte";
  import { burgerMenu, screenWidth, theme } from "$lib/common/stores";
  import LogoFull from "./LogoFull.svelte";
  import Tabs from "./Tabs.svelte";
  import { ROUTES } from "../routes";
  import Only from "./Only.svelte";
  import { MODES, SCREEN } from "../constant";
  import { page } from "$app/stores";
  import { goto } from "$app/navigation";

  const openBurger = () => {
    burgerMenu.set(true);
  };
</script>

<header>
  <div class="logo-wrapper">
    <LogoFull />
  </div>
  <div class="inner">
    <Only from="tablet">
      <div class="tabs-wrapper">
        <Tabs
          options={ROUTES.map(({ route, label, Icon }) => ({
            value: route,
            label,
            Icon: $screenWidth > SCREEN.desktop ? Icon : undefined,
          }))}
          fullWidth
          onChange={goto}
          selected={$page.route.id}
        />
      </div>
    </Only>

    <Only to="tablet">
      <BurgerButton onlyBurger onClick={openBurger} open={$burgerMenu} />
    </Only>
  </div>
  <Only from="tablet">
    <div class="modes-wrapper">
      <Tabs
        options={MODES}
        selected={$theme}
        onChange={theme.updateTheme}
        variant="secondary"
      />
    </div>
  </Only>
</header>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .logo-wrapper {
    height: 50px;
    width: 200px;
    position: absolute;
    left: 0px;
    top: 50%;
    transform: translateY(-50%);
  }

  .tabs-wrapper {
    display: flex;
    gap: 16px;
    max-width: 900px;
    margin: 0 auto;

    min-width: 400px;

    @include respond-to("desktop") {
      min-width: 600px;
    }

    @include respond-to("largeDesktop") {
      min-width: 800px;
    }
  }

  header {
    background-color: var(--uni-primary);
    color: var(--uni-on-primary);
    padding: 16px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: var(--uni-zIndex-app-bar);
    position: sticky;
    top: 0;
    display: flex;
    justify-content: flex-end;

    @include respond-to("tablet") {
      justify-content: center;
    }
  }

  .inner {
    position: relative;
  }

  .modes-wrapper {
    position: absolute;
    right: 0px;
    top: 50%;
    transform: translateY(-50%);

    @include respond-to("tablet") {
      width: 120px;
    }

    @include respond-to("desktop") {
      width: 160px;
    }

    @include respond-to("largeDesktop") {
      width: 200px;
    }
  }
</style>
