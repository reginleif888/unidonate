<script>
  import { snackbarStore } from "$lib/common/stores";
  import InlineNotification from "../inline-notification.svelte";
  import SnackbarContainer from "./snackbar-container.svelte";
  import { portal } from "$lib/common/actions";
  import CircularProgress from "../circular-progress.svelte";

  const mapTypeToTile = {
    error: "Oops...",
    success: "Success",
  };
</script>

<div class="snackbar-root" use:portal>
  {#each $snackbarStore as snackbar (snackbar.id)}
    <SnackbarContainer>
      <InlineNotification
        title={mapTypeToTile[snackbar.type]}
        type={snackbar.type}
        message={snackbar.message}
      >
        <div slot="end">
          <CircularProgress duration={snackbar.timeout - 100} />
        </div>
      </InlineNotification>
    </SnackbarContainer>
  {/each}
</div>

<style>
  .snackbar-root {
    position: fixed;
    right: 16px;
    top: 100px;
    z-index: var(--uni-zIndex-snackbar);
    min-width: 400px;
    display: flex;
    flex-direction: column;
    gap: 8px;
  }
</style>
