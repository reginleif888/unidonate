<script lang="ts">
  import { burgerOpened } from "$lib/common/stores/burgerOpened";

  function toggle() {
    burgerOpened.update((value) => !value);
  }
</script>

<!-- svelte-ignore a11y-click-events-have-key-events -->
<div
  class="burger {$burgerOpened ? 'isOpen' : ''}"
  on:click={toggle}
  role="button"
  tabindex="0"
>
  <div class="line line1"></div>
  <div class="line line2"></div>
  <div class="line line3"></div>
</div>

<style>
  .burger {
    cursor: pointer;
    width: 24px;
    height: 23px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    transition: transform 0.3s ease;
    position: relative;
  }

  .line {
    width: 100%;
    height: 1px;
    background-color: var(--brand-secondary-color);
    transition:
      transform 0.3s ease,
      opacity 0.3s ease;
  }

  .line1 {
    transform: translateY(0);
  }

  .line3 {
    transform: translateY(0);
  }

  .isOpen .line1 {
    transform: translateY(11px) rotate(45deg);
  }

  .isOpen .line2 {
    opacity: 0;
  }

  .isOpen .line3 {
    transform: translateY(-11px) rotate(-45deg);
  }
</style>
