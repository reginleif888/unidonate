<script lang="ts">
  export let title: string = "";
  export let description: string = "";
  export let desktopReverse: boolean = false;
</script>

<div class="root" class:desktop-reverse={desktopReverse}>
  <div class="info-root" class:desktop-reverse={desktopReverse}>
    <span class="info-root__title h3">{title}</span>
    <span class="info-root__description h6">{description}</span>
  </div>
  <div class="icon-wrapper"><slot name="icon" /></div>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  .root {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 16px;
    border-radius: 16px;
    background: var(--uni-secondary);
    justify-content: space-between;
    padding: 24px;
    box-shadow: var(--uni-shadow-paper);

    @include respond-to("desktop") {
      flex-wrap: nowrap;
    }
  }

  .desktop-reverse {
    @include respond-to("desktop") {
      flex-wrap: nowrap;
      flex-direction: row-reverse;
    }
  }

  .info-root {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    gap: 32px;
    min-width: 200px;

    @include respond-to("desktop") {
      width: 70%;
      text-align: left;
      justify-content: flex-start;
      align-items: flex-start;
      margin-right: auto;
      margin-left: 0;

      &__description {
        width: 90%;
      }
    }

    &.desktop-reverse {
      @include respond-to("desktop") {
        margin-right: 0;
        margin-left: auto;
      }
    }
  }

  .icon-wrapper {
    width: 200px;
    min-width: 140px;
    background: var(--uni-primary-gradient);
    padding: 16px;
    border-radius: 16px;
    margin: 0 auto;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-shrink: 0;

    @include respond-to("desktop") {
      margin: 0;
    }

    @include respond-to("largeDesktop") {
      min-width: 160px;
    }

    box-shadow: var(--uni-shadow-paper);
  }
</style>
