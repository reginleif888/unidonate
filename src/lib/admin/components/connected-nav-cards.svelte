<script>
  import { goto } from "$app/navigation";
  import { AdminRoute } from "$lib/common/routes";
  import { ArrowRight } from "phosphor-svelte";
  import { fly } from "svelte/transition";

  function goToSchoolsAndStudents() {
    goto(AdminRoute.Schools);
  }

  function goToOwners() {
    goto(AdminRoute.Owners);
  }
</script>

<div class="root">
  <button
    class="card h6"
    on:click={goToSchoolsAndStudents}
    transition:fly={{ x: -200, duration: 1000, opacity: 0 }}
  >
    Schools & Students <div class="icon-wrapper">
      <ArrowRight />
    </div>
  </button>
  <button
    class="card h6"
    on:click={goToOwners}
    transition:fly={{ x: 200, duration: 1000, opacity: 0 }}
  >
    Owners <div class="icon-wrapper">
      <ArrowRight />
    </div>
  </button>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .root {
    display: flex;
    flex-direction: column;
    gap: 16px;

    @include respond-to("smallTablet") {
      flex-direction: row;
    }
  }

  .card {
    width: 260px;
    padding: 16px;
    border: 1px solid var(--uni-on-primary);
    border-radius: 4px;
    position: relative;
    display: flex;
    background-color: transparent;
    color: var(--uni-on-primary);
    cursor: pointer;
    transition: all var(--uni-transition-default);

    &:hover {
      background-color: var(--uni-on-primary);
      color: var(--uni-primary);
    }
  }

  .icon-wrapper {
    position: absolute;
    right: 16px;
    top: 52%;
    transform: translateY(-50%);
  }
</style>
