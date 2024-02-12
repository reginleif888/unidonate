<script lang="ts">
  export let title: string = "";
  export let description: string = "";
</script>

<div class="root">
  <div class="info-root">
    <span class="info-root__title h3">{title}</span>
    <span class="info-root__description h6">{description}</span>
  </div>
  <slot />
</div>

<style lang="scss">
  .root {
    display: flex;
    flex-direction: column;
    gap: 16px;
    border-radius: 16px;
    background-color: var(--uni-secondary);
  }

  .info-root {
    display: flex;
    flex-direction: column;
    gap: 24px;
    padding: 24px;
  }
</style>
