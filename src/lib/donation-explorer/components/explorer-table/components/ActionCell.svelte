<script>
  import { ArrowSquareOut } from "phosphor-svelte";
</script>

<div>
  <button>
    <ArrowSquareOut size={32} />
  </button>
</div>

<style lang="scss">
  button {
    background-color: transparent;
    border: none;
    cursor: pointer;
    padding: 0;
    position: relative;
    top: -4px;
    color: var(--uni-on-bg);

    &:hover {
      color: var(--uni-primary);
    }
  }
</style>
