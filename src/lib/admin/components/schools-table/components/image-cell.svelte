<script lang="ts">
  import type { FormAdminSchool } from "$lib/admin/types";
  import { getImageLink } from "$lib/common/utils";

  export let origin: FormAdminSchool;

  let imgSrc = origin.images[0]
    ? getImageLink(origin.images[0].id)
    : "/images/no-image.webp";

  function handleError() {
    imgSrc = "/images/no-image.webp";
  }
</script>

<div>
  <img src={imgSrc} alt="school" on:error={handleError} />
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  
  img {
    width: 100%;

  @include respond-to("desktop") {
      
      width: 40px;
    }
  }
</style>
