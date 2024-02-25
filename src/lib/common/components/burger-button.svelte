<script lang="ts">
  export let open: boolean = false;
  export let onlyBurger: boolean = false;
</script>

<button on:click class="burger-menu-button">
  <div class={`burger-menu-line ${open && !onlyBurger ? "open" : ""}`}></div>
  <div class={`burger-menu-line ${open && !onlyBurger ? "open" : ""}`}></div>
  <div class={`burger-menu-line ${open && !onlyBurger ? "open" : ""}`}></div>
</button>

<style>
  .burger-menu-button {
    background: none;
    border: none;
    cursor: pointer;
  }

  .burger-menu-line {
    width: 30px;
    height: 2px;
    background: var(--uni-on-primary);
    margin: 5px 0;
    transition: all 0.3s ease;
  }

  .burger-menu-line.open:nth-child(1) {
    transform: translateY(8px) rotate(45deg);
  }

  .burger-menu-line.open:nth-child(3) {
    transform: translateY(-6px) rotate(-45deg);
  }

  .burger-menu-line.open:nth-child(2) {
    opacity: 0;
  }
</style>
