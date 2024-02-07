<script lang="ts">
  import PieChart from "$lib/common/components/PieChart.svelte";
  import Tooltip from "$lib/common/components/Tooltip.svelte";
</script>

<div class="h1">explorer</div>

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
        {
          color: "var(--info-color)",
          value: 24,
          label: "Lunch and snacks",
        },
      ]}
    />
  </svelte:fragment>
</Tooltip>
