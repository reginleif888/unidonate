<script>
  import { authClientStore } from "$lib/common/stores";
</script>

<div class="your-principal-root body2">
  <span class="label">Your principal:</span>
  <span>{$authClientStore?.getIdentity().getPrincipal()}</span>
</div>

<style>
  .your-principal-root {
    color: var(--uni-text-color-500);
    display: flex;
    flex-direction: column;
    gap: 4px;
    margin-left: auto;
    width: max-content;
  }

  .label {
    color: var(--uni-on-bg);
  }
</style>
