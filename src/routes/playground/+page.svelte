<script lang="ts">
  import Pagination from "$lib/common/components/Pagination.svelte";
  import PieChart from "$lib/common/components/PieChart.svelte";
  import Slider from "$lib/common/components/Slider.svelte";
  import ThemeSwitch from "$lib/common/components/ThemeSwitch.svelte";
  import Tooltip from "$lib/common/components/Tooltip.svelte";
  import CardGrid from "$lib/donate/components/CardGrid.svelte";
  import DonationForm from "$lib/donate/components/DonationForm.svelte";
  import UniGrid from "$lib/donate/components/UniGrid.svelte";
  import { schools } from "$lib/donate/mocks";
  import Donate from "$lib/donate/pages/Donate.svelte";
  import { mapSchoolsToGridItems } from "$lib/donate/utils";
</script>

<svelte:head>
  <title>Vite + SvelteKit + Motoko</title>
</svelte:head>

<div class="container">
  Hello World!
  <ThemeSwitch />

  <p class="body1">This is a test page for Vite + SvelteKit + Motoko</p>

  <Donate />

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
</div>

<style>
  .container {
    padding: 0 8px;
  }
</style>
