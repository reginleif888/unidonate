<script>
  import { burgerOpened } from "../stores/burgerOpened";

  function toggleMenu() {
    burgerOpened.update((state) => !state);
  }
</script>

<div class="menu-content" class:open={$burgerOpened}>
  <button class="menu-item subtitle1" on:click={toggleMenu}>Home</button>
  <button class="menu-item subtitle1" on:click={toggleMenu}>Donate</button>
  <button class="menu-item subtitle1" on:click={toggleMenu}
    >Donation explorer</button
  >
  <button class="menu-item subtitle1" on:click={toggleMenu}
    >Confirm donate</button
  >
</div>

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
    cursor: pointer;
    position: relative;
  }
</style>
