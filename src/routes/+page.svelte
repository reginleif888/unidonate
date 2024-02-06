<script lang="ts">
  import PieChart from "$lib/common/components/PieChart.svelte";
  import ThemeSwitch from "$lib/common/components/ThemeSwitch.svelte";
  import Tooltip from "$lib/common/components/Tooltip.svelte";
</script>

<svelte:head>
  <title>Vite + SvelteKit + Motoko</title>
</svelte:head>

<div class="h1">
  Hello World!
  <ThemeSwitch />

  <p class="body1">This is a test page for Vite + SvelteKit + Motoko</p>

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
