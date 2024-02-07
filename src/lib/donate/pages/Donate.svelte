<script lang="ts">
  import DonationForm from "../components/DonationForm.svelte";

  import InlineNotification from "$lib/common/components/InlineNotification.svelte";

  import UniGrid from "../components/UniGrid.svelte";
  import StudentGrid from "../components/StudentGrid.svelte";

  export let uniId: string = "";

  export let studentId: string = "";
</script>

<div class="container">
  <h1 class="h1">Donate</h1>

  <InlineNotification
    type="info"
    title="Donation process"
    message="Before all you have to select the university you want to donate to or university plus student. 
    Then you can allocate the budget for each category separately. Note that sum of all categories should be equal to the total amount."
  />

  <h1 class="h2 title-margin">Select your university</h1>
  <UniGrid bind:uniId />

  {#if uniId}
    <h1 id="student-select" class="h1">Select your student</h1>
    <h1 class="h3 title-margin">
      Select student you want to donate to or <a
        href="#donation-form"
        class="go-to-donation-form">go to donation form</a
      >
    </h1>
    <StudentGrid {uniId} bind:studentId />

    <div id="donation-form" class="title-margin">
      <h1 class="h1 matin-title">Donate to</h1>
      <p class="subtitle2">University: <span class="subtitle1">Nure</span></p>
      .
      <p class="subtitle2">
        Student: <span class="subtitle1">Sasha Lysenko</span>
      </p>
    </div>

    <DonationForm {studentId} {uniId} />
  {/if}
</div>

<style>
  .go-to-donation-form {
    color: var(--brand-primary-color);
  }

  .title-margin {
    margin-bottom: 20px;
  }

  .container {
    display: flex;
    flex-direction: column;
    gap: 20px;
  }
</style>
