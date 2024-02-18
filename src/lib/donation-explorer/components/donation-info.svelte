<script lang="ts">
  import { MAP_ALLOCATION_CATEGORY } from "$lib/donate/constant";
  import { ArrowLeft } from "phosphor-svelte";
  import type { FormDonation } from "../types";
  import { donationsMock } from "../mocks";
  import { AllocationCategory } from "$lib/donate/types";
  import { goto } from "$app/navigation";
  import { Route } from "$lib/common/routes";

  const donation: FormDonation = donationsMock[0];

  function goToExplorer() {
    goto(Route.Explorer);
  }
</script>

<div class="donation-info-root">
  <button class="donation-info-root__go-back body1" on:click={goToExplorer}>
    <ArrowLeft />Explore all donations
  </button>

  <table class="donation-info-root__table body2">
    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Donation transaction Id:</td
      >
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        1d01a1a8-c7b8-4d46-9dd3-b9876549916f
      </td>
    </tr>

    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Bitcoin transaction Id:</td
      >
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        2c5445d0d61365082e78d69203db75307a4493e35986fe1f8120257701151527
      </td>
    </tr>

    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key">
        School:
      </td>
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        Harvard
      </td>
    </tr>

    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key">
        Student:
      </td>
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        Mikki Mouse
      </td>
    </tr>

    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Payment address:</td
      >
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        1d01vv8-c7b28-4dd6-9dd3-b98165499ax16f
      </td>
    </tr>
    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Amount:</td
      >
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        0.000021 BTC
      </td>
    </tr>
    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Allocations:
      </td>
      <td class="donation-info-root__info-cell">
        <div class="donation-info-root__allocations">
          <div class="donation-info-root__allocation">
            {MAP_ALLOCATION_CATEGORY[AllocationCategory.DesignAndDevelopment]
              .label} - {donation.allocations[
              AllocationCategory.DesignAndDevelopment
            ]}%
          </div>

          <div class="donation-info-root__allocation">
            {MAP_ALLOCATION_CATEGORY[AllocationCategory.TeacherSupport].label} -
            {donation.allocations[AllocationCategory.TeacherSupport]}%
          </div>

          <div class="donation-info-root__allocation">
            {MAP_ALLOCATION_CATEGORY[AllocationCategory.SchoolSupplies].label} -
            {donation.allocations[AllocationCategory.SchoolSupplies]}%
          </div>

          <div class="donation-info-root__allocation">
            {MAP_ALLOCATION_CATEGORY[AllocationCategory.LunchAndSnacks].label} -
            {donation.allocations[AllocationCategory.LunchAndSnacks]}%
          </div>
        </div>
      </td>
    </tr>
  </table>
</div>

<style lang="scss">
  .donation-info-root {
    padding: 24px;
    background-color: var(--uni-bg-transparent-900);
    border-radius: 24px;
    display: flex;
    flex-direction: column;
    gap: 16px;
    width: 100%;
    max-width: 900px;
    z-index: 1;
    box-shadow: var(--uni-bg-shadow-paper);

    &__info-key {
      font-weight: bold;
    }

    &__go-back {
      background-color: transparent;
      border: none;
      cursor: pointer;
      padding: 0;
      display: flex;
      align-items: center;
      gap: 8px;
      color: var(--uni-on-bg);

      &:hover {
        color: var(--uni-primary);
      }
    }

    &__row:not(:last-child) {
      border-bottom: 1px solid var(--uni-divider-color);
    }

    &__table {
      overflow: hidden;
    }

    &__info-cell {
      padding: 16px;
    }

    &__info-value {
      padding: 16px;
      word-break: break-all;
    }
  }
</style>
