<script lang="ts">
  import type { FormAdminSchool } from "$lib/admin/types";

  export let origin: FormAdminSchool;
</script>

<div>
  <img src={origin.images[0]?.id} alt="school" />
</div>

<style lang="scss">
  img {
    width: 40px;
    height: 40px;
  }
</style>
