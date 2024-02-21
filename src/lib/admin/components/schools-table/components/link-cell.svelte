<script lang="ts">
  import type { FormAdminSchool } from "$lib/admin/types";

  export let origin: FormAdminSchool;
</script>

<div>
  <a href={`${origin.website}`} target="_blank">{origin.website}</a>
</div>

<style lang="scss">
  a {
    color: var(--uni-on-bg);
  }
</style>
