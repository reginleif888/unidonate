<script lang="ts">
  import type { FormAdminStudent } from "$lib/admin/types";
  import { getImageLink } from "$lib/common/utils";

  export let origin: FormAdminStudent;

  let imgSrc = origin.images[0]
    ? getImageLink(origin.images[0].id)
    : "/images/no-image.jpg";

  function handleError() {
    imgSrc = "/images/no-image.jpg";
  }
</script>

<div>
  <img src={imgSrc} alt="school" on:error={handleError} />
</div>

<style lang="scss">
  img {
    width: 40px;
    height: 40px;
  }
</style>
