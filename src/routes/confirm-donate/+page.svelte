<script lang="ts">
  import {
    Page,
    Button,
    InputWithLabel,
    Input,
    FireworksBg,
    InlineNotification,
  } from "$lib/common/components";

  let outerEl: HTMLElement;

  let fireworks = false;
</script>

<Page>
  <div class="outer" bind:this={outerEl}>
    <div class="inner">
      <h1 class="h4">Confirm donation</h1>

      <p class="body1">
        To confirm the donation, the transaction must be processed. Sometimes
        this can take some time, and if you receive an error, please try again
        later.
      </p>

      <InputWithLabel required label="Donation transaction Id (DTI)">
        <Input placeholder="My DTI..." />
      </InputWithLabel>
      <InputWithLabel required label="Bitcoin transaction Id (TXID)">
        <Input placeholder="My TXID..." />
      </InputWithLabel>
      <Button
        label="Confirm"
        contained
        on:click={() => {
          fireworks = true;
        }}
      />
    </div>
    {#if outerEl && fireworks}
      <FireworksBg
        width={outerEl.getBoundingClientRect().width}
        height={outerEl.getBoundingClientRect().height}
        numberOfParticles={100}
        maxFireworks={30}
        onFinish={() => (fireworks = false)}
      />
    {/if}
  </div>
</Page>

<style>
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
    padding: 24px;
    background-color: var(--uni-bg-transparent-700);
    border-radius: 24px;
    display: flex;
    flex-direction: column;
    gap: 16px;
    width: 100%;
    max-width: 600px;
    z-index: 1;
  }
</style>
