<script>
  export let size = "40px";
  export let color = "#007bff";
</script>

<div class="overlay">
  <div class="spinner" style="--size: {size}; --color: {color};"></div>
</div>

<style>
  .overlay {
    opacity: 0.5;
    background-color: var(--overlay-bg);
    backdrop-filter: blur(3.5px);
    inset: 0;
    position: absolute;
    z-index: 50;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .spinner {
    border: 4px solid var(--divider-color);
    border-radius: 50%;
    border-top: 4px solid var(--brand-primary-color);
    width: 80px;
    height: 80px;
    animation: spin 0.5s linear infinite;
  }

  @keyframes spin {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
</style>
