<script lang="ts">
  export let type: "horizontal" | "vertical" = "horizontal";
</script>

<div
  class="divider"
  class:horizontal={type === "horizontal"}
  class:vertical={type === "vertical"}
/>

<style>
  .divider {
    background-color: var(--uni-divider-color);
  }

  .divider.vertical {
    width: 1px;
    height: 100%;
  }

  .divider.horizontal {
    width: 100%;
    height: 1px;
  }
</style>
