<script lang="ts">
  import { goto } from "$app/navigation";
  import type { FormAdminSchool } from "$lib/admin/types";
  import { Tooltip } from "$lib/common/components";
  import { AdminRoute } from "$lib/common/routes";
  import { Pencil, ArrowSquareOut } from "phosphor-svelte";

  export let origin: FormAdminSchool;

  const handleEdit = () => {
    console.log("Edit school");
  };

  const handleShowStudents = () => {
    goto(AdminRoute.Students.replace("[schoolId]", origin.id));
  };
</script>

<div class="root">
  <Tooltip side="left" closeDelay={0}>
    <button slot="trigger" class="trigger" on:click={handleEdit}>
      <Pencil size={24} />
    </button>
    <div slot="content">Edit</div>
  </Tooltip>
  <Tooltip side="left" closeDelay={0}>
    <button slot="trigger" class="trigger" on:click={handleShowStudents}>
      <ArrowSquareOut size={24} />
    </button>
    <div slot="content">Show students</div>
  </Tooltip>
</div>

<style lang="scss">
  .root {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-evenly;
    gap: 16px;
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
