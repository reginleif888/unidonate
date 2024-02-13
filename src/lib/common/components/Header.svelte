<script>
  import BurgerButton from "./BurgerButton.svelte";
  import { burgerMenu, theme } from "$lib/common/stores";
  import LogoFull from "./LogoFull.svelte";
  import Tabs from "./Tabs.svelte";
  import { ROUTES } from "../routes";
  import Only from "./Only.svelte";
  import { MODES } from "../constant";
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
    <Only from="desktop"
      ><div class="tabs-wrapper">
        <Tabs
          options={ROUTES.map(({ route, label, Icon }) => ({
            value: route,
            label,
            Icon,
          }))}
          fullWidth
          onChange={goto}
          selected={$page.route.id}
        />
      </div>
    </Only>

    <Only to="desktop">
      <BurgerButton onlyBurger onClick={openBurger} open={$burgerMenu} />
    </Only>
  </div>
  <Only from="desktop">
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
    min-width: 600px;
    margin: 0 auto;
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

    @include respond-to("desktop") {
      justify-content: center;
    }
  }

  .inner {
    position: relative;
  }

  .modes-wrapper {
    width: 200px;
    position: absolute;
    right: 0px;
    top: 50%;
    transform: translateY(-50%);
  }
</style>
