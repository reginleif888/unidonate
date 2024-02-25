<script>
  import { goto } from "$app/navigation";
  import { Button } from "$lib/common/components";
  import { AppRoute } from "$lib/common/routes";
  import { HandHeart } from "phosphor-svelte";
</script>

<div class="root">
  <h1 class="h1 header">Start Contributing to Education on the Blockchain</h1>

  <div class="body2 description">
    Make a difference today with Bitcoin donations
  </div>

  <Button
    label="Support schools and students"
    contained
    on:click={() => {
      goto(AppRoute.Donate);
    }}
  >
    <span slot="end-icon" class="hand-icon">
      <HandHeart size={20} />
    </span>
  </Button>
</div>

<style>
  .root {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .header {
    text-align: center;
  }

  .description {
    text-align: center;
    margin-bottom: 40px;
  }

  .hand-icon {
    margin-left: 8px;
    position: relative;
    top: 2px;
  }
</style>
