<script>
  import InfoCard from "./info-card.svelte";
</script>

<InfoCard
  title="Empower Education with Your Donations"
  description="Contribute to educational causes for schools and students through Bitcoin on a decentralized platform, ensuring transparency and direct impact."
>
  <div class="icon" slot="icon">🫶</div>
</InfoCard>
<InfoCard
  title="Seamless Donation Statistic"
  description="View all donations in real-time, with a transparent ledger powered by the Internet Computer blockchain."
  desktopReverse
>
  <div class="icon" slot="icon">📝</div>
</InfoCard>
<InfoCard
  title="Flexible Donation Allocation"
  description="Easily allocate funds to specific needs, such as 20% for lunch & snacks and 80% for teacher support, ensuring donations meet the most critical requirements."
>
  <div class="icon categories-icons" slot="icon">
    <div class="categories-icon">👨‍💻</div>
    <div class="categories-icon">🥪</div>
    <div class="categories-icon">🎒</div>
    <div class="categories-icon">🧑‍🏫</div>
  </div>
</InfoCard>
<InfoCard
  title="Innovative Funding for Education"
  description="Our platform leverages the Internet Computer to provide an unprecedented level of scalability and affordability for educational donations."
  desktopReverse
>
  <div class="icon" slot="icon">🎓</div>
</InfoCard>

<style lang="scss">
  @import "$lib/common/styles/media.scss";
  .icon {
    color: var(--uni-on-primary);
    width: 120px;
    height: 120px;
    font-size: 120px;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
  }

  .categories-icons {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    justify-content: center;
    gap: 24px;
    font-size: 40px;
  }
</style>
