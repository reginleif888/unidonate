<script lang="ts">
  import { SvelteComponent, onMount } from "svelte";
  let ClientOnlyComponent: typeof SvelteComponent<any>;

  onMount(async () => {
    const module = await import("$lib/common/components/Stars.svelte");
    ClientOnlyComponent = module.default;
  });
</script>

<section>
  <svelte:component this={ClientOnlyComponent} />
  <div class="inner-container">
    <div class="inner">
      <slot />
    </div>
  </div>
</section>

<style lang="scss">
  section {
    background: var(--uni-page-gradient);
    position: relative;
    height: 100%;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
    height: 0;
    overflow: hidden;
  }

  .inner-container {
    width: 100%;
    margin: 0 auto;
    max-width: 1400px;
    padding: 24px 8px;
    display: flex;
    flex-direction: column;
    height: 0;
    flex-grow: 1;
  }

  .inner {
    flex-grow: 1;
    box-shadow: var(--uni-shadow-paper);
    border-radius: 24px;
    padding: 24px;
    z-index: 3;
    position: relative;
    overflow: scroll;
    background-color: var(--uni-bg-transparent-700);
    &::before {
      content: "";
      position: absolute;
      filter: blur(2px);
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      opacity: 0.7;
      z-index: -1;
      border-radius: 24px;
    }
  }
</style>
