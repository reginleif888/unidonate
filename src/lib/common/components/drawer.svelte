<script lang="ts">
  import { clickOutside } from "../actions";

  export let open: boolean = false;
  export let position: "left" | "right" | "bottom" | "top" = "left";
  export let onClose: () => void = () => null;
</script>

<div
  class="drawer"
  class:left={position === "left"}
  class:right={position === "right"}
  class:bottom={position === "bottom"}
  class:top={position === "top"}
  class:open
  use:clickOutside
  on:clickoutside={onClose}
>
  <slot />
</div>

<style>
  .drawer {
    position: fixed;
    width: 100%;
    height: 100%;
    background-color: var(--uni-bg);
    transition: all var(--uni-transition-default);
    z-index: var(--uni-zIndex-drawer);
  }

  .left {
    left: -100%;
  }

  .left.open {
    left: 0;
  }

  .right {
    right: -100%;
  }

  .right.open {
    right: 0;
  }

  .bottom {
    bottom: -100%;
  }

  .bottom.open {
    bottom: 0;
  }

  .top {
    top: -100%;
  }

  .top.open {
    top: 0;
  }
</style>
