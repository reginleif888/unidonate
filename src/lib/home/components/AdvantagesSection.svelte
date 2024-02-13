<script>
  import InfoCard from "./InfoCard.svelte";
  import {
    EmpowerEducation,
    FundingForEducation,
    DonationStatistic,
  } from "./AdvantagesIcons";
  import {
    LunchAndSnacks,
    SchoolSupplies,
    DesignAndDevelopment,
    TeacherSupport,
  } from "$lib/donate/components";
</script>

<InfoCard
  title="Empower Education with Your Donations"
  description="Contribute to educational causes for schools and students through Bitcoin on a decentralized platform, ensuring transparency and direct impact."
>
  <div class="icon" slot="icon">
    <EmpowerEducation />
  </div>
</InfoCard>
<InfoCard
  title="Seamless Donation Statistic"
  description="View and manage all donations in real-time, with a transparent ledger powered by the Internet Computer blockchain."
  desktopReverse
>
  <div class="icon" slot="icon">
    <DonationStatistic />
  </div>
</InfoCard>
<InfoCard
  title="Flexible Donation Allocation"
  description="Easily allocate funds to specific needs, such as 20% for lunch & snacks and 80% for teacher support, ensuring donations meet the most critical requirements."
>
  <div class="icon categories-icons" slot="icon">
    <div class="categories-icon">
      <LunchAndSnacks />
    </div>
    <div class="categories-icon">
      <SchoolSupplies />
    </div>
    <div class="categories-icon">
      <DesignAndDevelopment />
    </div>
    <div class="categories-icon">
      <TeacherSupport />
    </div>
  </div>
</InfoCard>
<InfoCard
  title="Innovative Funding for Education"
  description="Our platform leverages the Internet Computer to provide an unprecedented level of scalability and affordability for educational donations."
  desktopReverse
>
  <div class="icon" slot="icon">
    <FundingForEducation />
  </div>
</InfoCard>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  .icon {
    color: var(--uni-on-primary);
  }

  .categories-icons {
    display: flex;
    gap: 24px;
    flex-wrap: wrap;
  }

  .categories-icon {
    width: 72px;

    @include respond-to("desktop") {
      width: 38px;
    }

    @include respond-to("largeDesktop") {
      width: 46px;
    }
  }
</style>
