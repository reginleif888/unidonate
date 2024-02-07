<script lang="ts">
  import PieChart from "$lib/common/components/PieChart.svelte";
  import Tooltip from "$lib/common/components/Tooltip.svelte";

  import type { Donation } from "../../../declarations/backend/backend.did";

  export let selected: boolean = false;
  export let donation: Donation;
</script>

<Tooltip>
  <svelte:fragment slot="trigger">
    <button class="root" class:selected>
      <div class="item__description">
        <div class="item__name subtitle2">
          <span>Donation id</span>: {donation.donationId}
        </div>
        <div class="item__value subtitle1">
          Donation transaction id: {donation.transactionId}
        </div>
        <div class="item__value subtitle1">
          Donation payment address: {donation.paymentAddress}
        </div>
        <div class="item__value subtitle1">
          Donation payment address: {donation.schoolId}
        </div>
        <div class="item__value subtitle1">
          Donation payment address: {donation.studentId}
        </div>
        <div class="item__value subtitle1">
          Donation payment address: {donation.status}
        </div>
        <div class="item__value subtitle1">
          Donation payment address: {donation.amount}
        </div>
        <div class="item__value subtitle1">Donation payment address: 1</div>
      </div>
    </button>
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

<style lang="scss">
  .root {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    height: fit-content;

    gap: 0.5rem;
    border: 1px solid var(--divider-color);
    background-color: var(--primary-bg);

    cursor: pointer;
    transition: var(--transition-default);
    padding: 0;

    &:hover {
      background-color: var(--secondary-button-hover-bg);
      box-shadow: (--shadow-card);
    }
  }

  .item__value {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    gap: 4px;
  }

  .selected {
    background-color: var(--secondary-button-hover-bg);
    border-color: var(--brand-secondary-color);
  }

  .item__img-container {
    width: 100%;
    height: 100px;
    position: relative;
    border-bottom: 1px solid var(--divider-color);
  }

  img {
    width: 100%;
    object-fit: cover;
    position: absolute;
    height: 100px;
    top: 0;
    left: 0;
    background-color: #fff;
    border-bottom: 1px solid var(--divider-color);
  }

  .item__description {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    padding: 8px;
    gap: 8px;
  }
</style>
