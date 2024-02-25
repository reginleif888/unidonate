<script lang="ts">
  import type { FormAdminStudent } from "$lib/admin/types";

  export let origin: FormAdminStudent;
</script>

<div class="root">
  <div
    class="dot"
    class:active={origin.active}
    class:in-active={!origin.active}
  />
</div>

<style lang="scss">
  .dot {
    width: 20px;
    height: 20px;
    border-radius: 50%;
  }

  .active {
    background-color: var(--uni-success-color);
  }

  .in-active {
    background-color: var(--uni-error-color);
  }
</style>
