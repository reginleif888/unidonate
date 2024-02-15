<script lang="ts">
  export let label: string = "";
  export let errorMessage: string = "";
</script>

<div>
  <label for={label}>{label}</label>
  <slot let-name={label} />
  <span>{errorMessage}</span>
</div>

<style></style>
