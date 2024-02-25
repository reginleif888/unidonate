<script lang="ts">
  import { MAP_ALLOCATION_CATEGORY } from "$lib/donate/constant";
  import { ArrowLeft } from "phosphor-svelte";
  import type { FormDonation } from "../types";
  import {
    AllocationCategory,
    type FormSchool,
    type FormStudent,
  } from "$lib/donate/types";
  import { goto } from "$app/navigation";
  import { AppRoute } from "$lib/common/routes";

  export let donation: FormDonation;
  export let school: FormSchool;
  export let student: FormStudent | null = null;

  function goToExplorer() {
    goto(AppRoute.Explorer);
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
        {donation.id}
      </td>
    </tr>

    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Bitcoin transaction Id:</td
      >
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        {donation.transactionId ? donation.transactionId : "N/A"}
      </td>
    </tr>

    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key">
        School:
      </td>
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        {school.name}
      </td>
    </tr>

    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key">
        Student:
      </td>
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        {student ? `${student.firstName} ${student.lastName}` : "N/A"}
      </td>
    </tr>

    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Payment address:</td
      >
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        {donation.paymentAddress}
      </td>
    </tr>
    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Amount:</td
      >
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        {donation.amount} BTC
      </td>
    </tr>
    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Verified At:</td
      >
      <td class="donation-info-root__info-cell donation-info-root__info-value">
        {donation.verifiedAt}
      </td>
    </tr>
    <tr class="donation-info-root__row">
      <td class="donation-info-root__info-cell donation-info-root__info-key"
        >Allocation:
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
