<script lang="ts">
  export let size: number = 20;
  export let color = "#007bff";
</script>

<div
  class="spinner"
  style="width: {size}px; height: {size}px; --color: {color};"
></div>

<style>
  .spinner {
    border: 2px solid var(--uni-primary);
    border-radius: 50%;
    border-top: 2px solid currentColor;
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
