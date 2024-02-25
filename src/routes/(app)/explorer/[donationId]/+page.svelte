<script lang="ts">
  import { fade } from "svelte/transition";
  import { InlineNotification, Page, Spinner } from "$lib/common/components";
  import {
    useGetDonationByIdQuery,
    useGetSchoolById,
    useGetStudentById,
  } from "$lib/donation-explorer/queries";
  import { page } from "$app/stores";
  import { ArrowLeft } from "phosphor-svelte";
  import { goto } from "$app/navigation";
  import { AppRoute } from "$lib/common/routes";
  import { DonationInfo } from "$lib/donation-explorer/components";
  import { mapDonationToForm } from "$lib/donation-explorer/mappers";
  import { mapSchoolToForm, mapStudentToForm } from "$lib/donate/mappers";

  $: donationQuery = useGetDonationByIdQuery({
    donationId: $page.params.donationId,
  });

  $: schoolQuery = useGetSchoolById({
    schoolId: $donationQuery.data?.schoolId!,
    enabled: Boolean($donationQuery.data?.schoolId),
  });

  $: studentQuery = useGetStudentById({
    studentId: $donationQuery.data?.studentId[0]!,
    enabled: Boolean($donationQuery.data?.studentId.length),
  });

  function goToExplorer() {
    goto(AppRoute.Explorer);
  }

  $: loading =
    $donationQuery.isLoading ||
    $studentQuery.isLoading ||
    $schoolQuery.isLoading;

  $: error =
    $donationQuery.isError || $studentQuery.isError || $schoolQuery.isError;
</script>

<Page>
  <div class="outer">
    <div class="inner">
      <div class="form-wrapper">
        {#if loading}
          <Spinner size={120} />
        {/if}

        {#if error}
          <div class="error-wrapper">
            <button
              class="error-wrapper__go-back body1"
              on:click={goToExplorer}
            >
              <ArrowLeft />Explore all donations
            </button>

            {#if $donationQuery.isError}
              <InlineNotification
                title="Oops..."
                message={`Donation with ${$page.params.donationId} was not found.`}
              />
            {/if}

            {#if $studentQuery.isError}
              <InlineNotification
                title="Oops..."
                message={`Student with ${$donationQuery.data?.studentId[0]} was not found.`}
              />
            {/if}

            {#if $schoolQuery.isError}
              <InlineNotification
                title="Oops..."
                message={`School with ${$donationQuery.data?.schoolId} was not found.`}
              />
            {/if}
          </div>
        {/if}

        {#if $donationQuery.data && $schoolQuery.data}
          <DonationInfo
            donation={mapDonationToForm($donationQuery.data)}
            school={mapSchoolToForm($schoolQuery.data)}
            student={$studentQuery.data
              ? mapStudentToForm($studentQuery.data)
              : null}
          />
        {/if}
      </div>
    </div>
  </div>
</Page>

<style lang="scss">
  .outer {
    height: 100%;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    position: relative;
  }

  .inner {
    overflow: auto;
    padding: 8px;
    width: 100%;
  }

  .form-wrapper {
    width: fit-content;
    margin: 0 auto;
  }

  .error-wrapper {
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

    &__go-back {
      background-color: transparent;
      border: none;
      cursor: pointer;
      padding: 0;
      display: flex;
      align-items: center;
      gap: 8px;
      color: var(--uni-on-bg);
    }
  }
</style>
