<script>
  import { authClientStore } from "$lib/common/stores";
</script>

<div class="your-principal-root caption">
  <span class="label">Your principal:</span>
  <span class="identity">{$authClientStore?.getIdentity().getPrincipal()}</span>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  .your-principal-root {
    color: var(--uni-text-color-500);
    display: flex;
    flex-direction: column;
    gap: 4px;
    margin-left: auto;
    text-align: right;

    @include respond-to("desktop") {
      width: max-content;
      font-size: 14px;
    }
  }

  .label {
    color: var(--uni-on-bg);
  }

  .identity {
    word-wrap: break-word;
  }
</style>
