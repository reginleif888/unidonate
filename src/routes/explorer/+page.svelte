<script lang="ts">
  import PieChart from "$lib/common/components/PieChart.svelte";
  import Tooltip from "$lib/common/components/Tooltip.svelte";
  import DonationGrid from "$lib/donation-explorer/component/DonationGrid.svelte";
</script>

<div class="h1">Explorer</div>

<segment>
  <DonationGrid />
</segment>
