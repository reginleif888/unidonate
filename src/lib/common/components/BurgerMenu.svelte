<script>
  import { burgerOpened } from "../stores/burgerOpened";

  function toggleMenu() {
    burgerOpened.update((state) => !state);
  }
</script>

<nav class="menu-content" class:open={$burgerOpened}>
  <ul>
    <li class="menu-item subtitle1">
      <a href="/" on:click={toggleMenu}>Home</a>
    </li>
    <li class="menu-item subtitle1">
      <a href="/donate" on:click={toggleMenu}>Donate</a>
    </li>
    <li class="menu-item subtitle1">
      <a href="/explorer" on:click={toggleMenu}>Donation explorer</a>
    </li>
    <li class="menu-item subtitle1">
      <a href="/confirm-donate" on:click={toggleMenu}>Confirm donate</a>
    </li>
  </ul>
</nav>

<style>
  .menu-content {
    position: fixed;
    top: 100px;
    left: 0;
    width: 100%;
    background-color: #fff;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
    transform: translateY(-300%);
    transition: transform 0.3s ease;
    z-index: 10;

    display: flex;
    flex-direction: column;
  }

  .menu-content.open {
    transform: translateY(0);
  }

  .menu-item {
    padding: 15px;
    border: unset;
    border-bottom: 1px solid var(--divider-color);
    background-color: var(--primary-bg);
    color: var(--brand-primary-color);
    cursor: pointer;
    position: relative;
  }

  .menu-item a {
    color: var(--brand-primary-color);
    display: flex;
    width: 100%;
    height: 100%;
  }

  .menu-item:hover {
    background-color: var(--secondary-bg);
    color: var(--brand-primary-color);
  }
</style>
