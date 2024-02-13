<script lang="ts">
  export let title: string = "";
  export let description: string = "";
</script>

<div class="root">
  <div class="info-root">
    <span class="info-root__title h3">{title}</span>
    <span class="info-root__description h6">{description}</span>
  </div>
  <div class="icon-wrapper"><slot name="icon" /></div>
</div>

<style lang="scss">
  .root {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 16px;
    border-radius: 16px;
    background: var(--uni-secondary);
    justify-content: space-between;
    padding: 24px;
  }

  .info-root {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    gap: 32px;
    min-width: 200px;
  }

  .icon-wrapper {
    width: 200px;
    background: var(--uni-primary-gradient);
    padding: 16px;
    border-radius: 16px;
    margin: 0 auto;
  }
</style>
