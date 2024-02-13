<script lang="ts">
  import { Divider } from "$lib/common/components";
  import {
    AdvantagesSection,
    MainSection,
    AboutSection,
  } from "$lib/home/components";
</script>

<section class="donation-section">
  <MainSection />
</section>

<Divider />

<section>
  <AdvantagesSection />
</section>

<Divider />

<section>
  <AboutSection />
</section>

<style lang="scss">
  section {
    display: flex;
    flex-direction: column;
    padding: 24px 8px;
    gap: 16px;

    max-width: 900px;
    margin: 0 auto;
  }

  .donation-section {
    align-items: flex-start;
    gap: 16px;
  }
</style>
