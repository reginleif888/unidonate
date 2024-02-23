<script lang="ts">
  import type { FormAdminStudent } from "$lib/admin/types";
  import { getImageLink } from "$lib/common/utils";

  export let origin: FormAdminStudent;
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
    height: 40px;
  }
</style>
