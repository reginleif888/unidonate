<script lang="ts">
  import { fade } from "svelte/transition";
  import { Button, Input, PieChart } from "$lib/common/components";
  import { CategoryDonationCard } from "$lib/donate/components";
  import { CurrencyBtc } from "phosphor-svelte";
</script>

<div class="root">
  <div class="inner">
    <div class="heading-section">
      <h4 class="h4 step-heading">Donate</h4>
      <div class="body1 step-description">Donate to a school or student</div>
    </div>

    <div class="budget-wrapper">
      <Input>
        <span slot="start-icon"><CurrencyBtc weight="bold" /></span>
      </Input>
    </div>

    <div class="categories-grid">
      <div class="card-wrapper">
        <CategoryDonationCard />
      </div>
      <div class="card-wrapper">
        <CategoryDonationCard />
      </div>
      <div class="card-wrapper">
        <CategoryDonationCard />
      </div>
      <div class="card-wrapper">
        <CategoryDonationCard />
      </div>
    </div>

    <div class="chart-wrapper">
      <PieChart
        width={260}
        height={260}
        data={[
          {
            color: "var(--uni-error-color)",
            value: 25,
            label: "Curriculum design and development",
          },
          {
            color: "var(--uni-success-color)",
            value: 25,
            label: "Teacher support",
          },
          {
            color: "var(--uni-warning-color)",
            value: 25,
            label: "School supplies",
          },
          {
            color: "var(--uni-info-color)",
            value: 25,
            label: "Lunch and snacks",
          },
        ]}
      />
    </div>
  </div>

  <div class="controls-section">
    <div class="controls-section-buttons">
      <Button
        label="Reset categories allocation"
        contained
        variant="secondary"
      />
      <Button label="Create donation" contained>
        <span slot="end-icon" class="h6">🎉</span>
      </Button>
    </div>
  </div>
</div>

<style>
  .root {
    background-color: var(--uni-bg-transparent-700);
    box-shadow: var(--uni-shadow-paper);
    width: 100%;
    height: 100%;
    overflow: scroll;
    display: flex;
    flex-direction: column;
  }

  .inner {
    display: flex;
    display: flex;
    flex-direction: column;
    width: 100%;
    height: 0;
    flex-grow: 1;
    padding: 16px;
  }

  .heading-section {
    padding-bottom: 0px;
  }

  .step-heading {
    margin-bottom: 8px;
  }

  .step-description {
    margin-bottom: 24px;
  }

  .categories-grid {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
  }

  .budget-wrapper {
    margin-bottom: 16px;
  }

  .card-wrapper {
    width: 100%;
    min-width: 300px;

    flex: 1 1 calc(50% - 8px);
  }

  .chart-wrapper {
    margin-bottom: 16px;
    display: flex;
    justify-content: center;
  }

  .controls-section {
    bottom: 0;
    position: sticky;
    background-color: var(--uni-bg);
    padding: 16px;
    border-top: 1px solid var(--uni-primary-transparent-70);
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
  }

  .controls-section-buttons {
    display: flex;
    gap: 16px;
    align-items: center;
    justify-content: flex-end;
    width: 100%;
  }
</style>
