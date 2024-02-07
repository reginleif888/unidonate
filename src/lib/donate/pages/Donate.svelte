<script>
  import DonationForm from "../components/DonationForm.svelte";

  import InlineNotification from "$lib/common/components/InlineNotification.svelte";

  import UniGrid from "../components/UniGrid.svelte";
  import ThemeSwitch from "$lib/common/components/ThemeSwitch.svelte";
  import Button from "$lib/common/components/Button.svelte";
  import { errorModal } from "$lib/common/stores/errorModal";
</script>

<div class="container">
  <ThemeSwitch />

  <Button
    label="open error modal"
    onClick={() => {
      errorModal.set({ isOpen: true, message: "This is an error message" });
    }}
  />

  <InlineNotification
    type="info"
    title="Donation process"
    message="Before all you have to select the university you want to donate to or university plus student. 
    Then you can allocate the budget for each category separately. Note that sum of all categories should be equal to the total amount."
  />

  <h1 class="h1 title-margin">Select your university</h1>
  <UniGrid />

  <h1 id="student-select" class="h1">Select your student</h1>
  <h1 class="h3 title-margin">
    Select student you want to donate to or <a
      href="#donation-form"
      class="go-to-donation-form">go to donation form</a
    >
  </h1>
  <UniGrid />

  <div id="donation-form" class="title-margin">
    <h1 class="h1 matin-title">Donate to</h1>
    <p class="subtitle2">University: <span class="subtitle1">Nure</span></p>
    .
    <p class="subtitle2">
      Student: <span class="subtitle1">Sasha Lysenko</span>
    </p>
  </div>

  <DonationForm />
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
