<div class="skeleton-card">
  <div class="skeleton skeleton-image"></div>

  <div class="skeleton-description">
    <div class="skeleton skeleton-text" style="width: 60%;"></div>
    <div class="skeleton skeleton-text"></div>
    <div class="skeleton skeleton-text"></div>
    <div class="skeleton skeleton-text"></div>
  </div>

  <div class="skeleton skeleton-button"></div>
</div>

<style>
  .skeleton-card {
    border-radius: 24px;
    padding: 16px;
    display: flex;
    flex-direction: column;
    gap: 16px;
    background-color: var(--uni-bg);
  }

  .skeleton {
    animation: skeleton-pulse 1.5s infinite ease-in-out;
  }

  .skeleton-text {
    height: 20px;
    width: 80%;
    border-radius: 4px;
  }

  .skeleton-button {
    padding: var(--uni-padding-button-medium);
    height: var(--uni-height-button-medium);
    border-radius: var(--uni-radius-button);
  }

  .skeleton-image {
    height: 200px;
    border-radius: 24px;
  }

  .skeleton-description {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }
</style>
