<script>
  import { goto } from "$app/navigation";
  import { Button } from "$lib/common/components";
  import { AppRoute } from "$lib/common/routes";
  import { ListMagnifyingGlass } from "phosphor-svelte";
</script>

<div class="root">
  <h1 class="h1 header">Empowering Education through Donations</h1>

  <div class="measurement">
    <span class="measurement__name subtitle2">Donations processed:</span>
    <span class="measurement__value h4">2500+</span>
  </div>

  <div class="body2 description">
    The UniDonate is dedicated to transforming the way we support education. By
    leveraging blockchain technology, we enable direct donations in Bitcoin,
    provide transparency in fund allocation, and allow donors to track their
    contributions in real time. With specific categories for donations, such as
    20% for meals and 80% for educational materials, we ensure that every
    contribution has a tangible impact.
  </div>

  <Button
    label="Explore donations"
    variant="secondary"
    contained
    on:click={() => {
      goto(AppRoute.Explorer);
    }}
  >
    <span slot="end-icon" class="explore-donations-icon">
      <ListMagnifyingGlass size={20} />
    </span>
  </Button>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .root {
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .header {
    text-align: center;
  }

  .measurement {
    padding: 16px;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin-bottom: 20px;
  }

  .measurement__name {
    margin-bottom: 8px;
    color: var(--uni-primary-1000);
  }

  .measurement__value {
    color: var(--uni-on-bg);
  }

  .description {
    text-align: center;
    margin-bottom: 40px;

    @include respond-to("tablet") {
      width: 90%;
    }
  }

  .explore-donations-icon {
    margin-left: 8px;
    position: relative;
    top: 2px;
  }
</style>
