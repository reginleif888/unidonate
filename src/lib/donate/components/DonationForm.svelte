<script>
  import Button from "$lib/common/components/Button.svelte";
  import InlineNotification from "$lib/common/components/InlineNotification.svelte";
  import Slider from "$lib/common/components/Slider.svelte";
  import TextInput from "$lib/common/components/TextInput.svelte";
  import Tooltip from "$lib/common/components/Tooltip.svelte";
  import { ArrowCounterClockwise, HandHeart } from "phosphor-svelte";
</script>

<div>
  <div class="top-section">
    <InlineNotification
      type="error"
      title="Ooops...💥"
      message="Seems like allocated budget is wrong. Please check it again."
    />

    <TextInput label="Amount" type="number" />

    <Tooltip>
      <slot slot="trigger">
        <Button label="Reset" variant="secondary">
          <svelte:fragment slot="end-icon">
            <ArrowCounterClockwise size={24} />
          </svelte:fragment>
        </Button>
      </slot>
      <slot slot="content">Allocate all categories to 25%</slot>
    </Tooltip>
  </div>

  <div class="slider-container">
    <Slider />
  </div>

  <div class="slider-container"><Slider /></div>

  <div class="slider-container"><Slider /></div>

  <div class="slider-container"><Slider /></div>

  <Button label="Donate" variant="primary" contained>
    <svelte:fragment slot="end-icon">
      <HandHeart size={24} />
    </svelte:fragment>
  </Button>
</div>

<style>
  .slider-container {
    display: flex;
    gap: 20px;
    margin-bottom: 40px;
  }

  .top-section {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 40px;
    gap: 20px;
  }
</style>
