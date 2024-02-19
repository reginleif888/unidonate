<script lang="ts">
  import type { FormAdminSchool } from "$lib/admin/types";
  import { Tooltip } from "$lib/common/components";
  import { Pencil } from "phosphor-svelte";

  export let origin: FormAdminSchool;
</script>

<div class="root">
  <Tooltip side="left" closeDelay={0}>
    <button slot="trigger" class="trigger">
      <Pencil size={24} />
    </button>
    <div slot="content">Edit Student</div>
  </Tooltip>
</div>

<style lang="scss">
  .root {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .trigger {
    color: var(--uni-on-bg);
    cursor: pointer;
    background-color: transparent;
    border: unset;
    padding: 0;

    &:hover {
      color: var(--uni-primary);
    }
  }
</style>
