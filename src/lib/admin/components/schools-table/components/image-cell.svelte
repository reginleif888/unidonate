<script lang="ts">
  import type { FormAdminSchool } from "$lib/admin/types";
  import { getImageLink } from "$lib/common/utils";

  export let origin: FormAdminSchool;
</script>

<div>
  <img
    src={origin.images[0] ? getImageLink(origin.images[0].id) : ""}
    alt="school"
  />
</div>

<style lang="scss">
  img {
    width: 40px;
  }
</style>
