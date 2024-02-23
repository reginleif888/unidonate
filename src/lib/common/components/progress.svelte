<script lang="ts">
  import { Progress } from "bits-ui";

  export let value = 0;
</script>

<Progress.Root {value} max={100} class="uni-ui-component-progress-root">
  <div
    class="uni-ui-component-progress-root__inner"
    style={`transform: translateX(-${
      100 - (100 * (value ?? 0)) / (100 ?? 1)
    }%)`}
  />
</Progress.Root>

<style lang="scss">
  :global(.uni-ui-component-progress-root) {
    overflow: hidden;
    position: relative;
    border-radius: 9999px;
    height: 15px;
    width: 100%;
    background: var(--uni-secondary);
  }

  :global(.uni-ui-component-progress-root__inner) {
    flex: 1 1 0%;
    border-radius: 9999px;
    width: 100%;
    height: 100%;
    transition-property: all;
    transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
    transition-duration: 300ms;
    transition-timing-function: linear;
    background: var(--uni-primary);
  }
</style>
