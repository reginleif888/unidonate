<script lang="ts">
  import { Page, Pagination } from "$lib/common/components";
  import Button from "$lib/common/components/Button.svelte";
</script>

<Page>
  <Button label="Back" variant="secondary" contained />
  <Button label="Next" variant="primary" contained />
  <div style="width: 400px">
    <Pagination count={7} perPage={5} />
  </div>
</Page>
