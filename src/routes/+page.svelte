<script lang="ts">
  import { Divider } from "$lib/common/components";
  import { AdvantagesSection, MainSection } from "$lib/home/components";
</script>

<section class="donation-section">
  <MainSection />
</section>

<Divider />

<section>
  <AdvantagesSection />
</section>

<style lang="scss">
  section {
    display: flex;
    flex-direction: column;
    padding: 24px 8px;
    gap: 16px;
  }

  .donation-section {
    align-items: flex-start;
    gap: 16px;
  }
</style>
