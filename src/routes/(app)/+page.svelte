<script lang="ts">
  import { Divider } from "$lib/common/components";
  import {
    AdvantagesSection,
    MainSection,
    AboutSection,
    StartContribution,
    PoweredBy,
  } from "$lib/home/components";
</script>

<div class="main-wrapper">
  <section>
    <MainSection />
  </section>
</div>

<Divider />

<div class="primary-bg">
  <section>
    <AdvantagesSection />
  </section>
</div>

<Divider />

<div>
  <section>
    <AboutSection />
  </section>
</div>

<Divider />

<div class="primary-bg">
  <section>
    <PoweredBy />
  </section>
</div>

<Divider />

<div>
  <section>
    <StartContribution />
  </section>
</div>

<style lang="scss">
  @import "$lib/common/styles/media.scss";

  .main-wrapper {
    width: 100%;
    height: 100%;
    background: url("https://i.giphy.com/sWFYgYFjHGugleQdO7.webp");
  }

  .primary-bg {
    background-color: var(--uni-primary-transparent-80);
    position: relative;
    z-index: 1;

    &::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: -1;
      opacity: 0.5;
      object-fit: scale-down;
      background-image: url("/images/digital-bg.webp");
    }
  }

  section {
    display: flex;
    flex-direction: column;
    padding: 24px 8px;
    gap: 16px;

    max-width: 1200px;
    margin: 0 auto;

    @include respond-to("largeDesktop") {
      padding: 24px 16px;
    }

    @include respond-to("largeDesktop") {
      padding: 48px 20px;
    }
  }
</style>
