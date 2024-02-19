<script lang="ts">
  import type { FormAdminSchool } from "$lib/admin/types";

  export let origin: FormAdminSchool;
</script>

<div>
  <img src={`http://localhost:3000/${origin.img}`} alt="school" />
</div>

<style lang="scss">
  img {
    width: 40px;
  }
</style>
