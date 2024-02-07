<script>
  import Button from "$lib/common/components/Button.svelte";
  import InlineNotification from "$lib/common/components/InlineNotification.svelte";
  import PieChart from "$lib/common/components/PieChart.svelte";
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
  </div>

  <div class="slider-container">
    <Slider />
  </div>

  <div class="slider-container"><Slider /></div>

  <div class="slider-container"><Slider /></div>

  <div class="slider-container"><Slider /></div>

  <Tooltip>
    <svelte:fragment slot="trigger">
      <p class="body2">14, 24, 24, 24</p>
    </svelte:fragment>
    <svelte:fragment slot="content">
      <PieChart
        data={[
          {
            color: "var(--error-color)",
            value: 14,
            label: "Curriculum design and development",
          },
          {
            color: "var(--success-color)",
            value: 24,
            label: "Teacher support",
          },
          {
            color: "var(--warning-color)",
            value: 24,
            label: "School supplies",
          },
          { color: "var(--info-color)", value: 24, label: "Lunch and snacks" },
        ]}
      />
    </svelte:fragment>
  </Tooltip>

  <div class="controls">
    <Tooltip>
      <slot slot="trigger">
        <Button label="Reset allocation" variant="secondary" contained>
          <svelte:fragment slot="end-icon">
            <ArrowCounterClockwise size={24} />
          </svelte:fragment>
        </Button>
      </slot>
      <slot slot="content">Allocate all categories to 25%</slot>
    </Tooltip>
    <Button label="Donate" variant="primary" contained>
      <svelte:fragment slot="end-icon">
        <HandHeart size={24} />
      </svelte:fragment>
    </Button>
  </div>
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

  .controls {
    display: flex;
    justify-content: space-between;
    flex-direction: column;
    align-items: center;
    gap: 20px;
    margin-bottom: 20px;
  }
</style>
