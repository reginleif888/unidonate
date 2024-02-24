<script lang="ts">
  import { Input, InputWithLabel, Tooltip } from "$lib/common/components";
  import { Swap } from "phosphor-svelte";

  export let currentCurrency = "BTC";

  export let btcValue: string = "";

  export let satsValue: string = "";

  export let numberBtcValue: number | null = 0;

  export let numberSatValue: number | null = 0;

  export let error: boolean = false;

  let placeholder = "0.00000000 BTC";

  function getDecimalSeparator() {
    const numberWithDecimal = 1.1;
    const formattedNumber = Intl.NumberFormat(window.navigator.language).format(
      numberWithDecimal
    );
    const decimalSeparator = formattedNumber.charAt(1);
    return decimalSeparator;
  }

  function satsToBtcString(sats: string) {
    let satsString = sats.toString();
    satsString = satsString.padStart(9, "0");
    const btcString =
      satsString.slice(0, -8) + getDecimalSeparator() + satsString.slice(-8);
    return btcString;
  }

  function btcToSatsString(btc: string) {
    let [whole, fractional] = btc.split(getDecimalSeparator());
    fractional = fractional || "";
    fractional = fractional.padEnd(8, "0");
    const sats = whole + fractional;
    return parseInt(sats, 10).toString();
  }

  function handleSwap() {
    if (currentCurrency === "BTC") {
      currentCurrency = "SATS";

      if (satsValue) {
        satsValue = btcToSatsString(btcValue);
      }
    } else {
      currentCurrency = "BTC";

      if (satsValue) {
        btcValue = satsToBtcString(satsValue);
      }
    }
  }

  function handleInput(event: Event) {
    const target = event.target as HTMLInputElement;

    if (!target.value) {
      btcValue = "";
      satsValue = "";

      return;
    }

    if (currentCurrency === "BTC") {
      btcValue = target.value;
      satsValue = btcToSatsString(btcValue);
    } else {
      satsValue = target.value;
      btcValue = satsToBtcString(satsValue);
    }
  }

  $: {
    placeholder =
      currentCurrency === "BTC"
        ? `0${getDecimalSeparator()}00000000 BTC`
        : "0 SATS";
  }

  $: {
    numberBtcValue = Number(
      Number(btcValue.replace(getDecimalSeparator(), ".")).toFixed(8)
    );
  }

  $: {
    numberSatValue = Number(satsValue);
  }
</script>

<InputWithLabel label={`Total ${currentCurrency}`}>
  {#if currentCurrency === "BTC"}
    <Input
      {placeholder}
      value={btcValue}
      {error}
      imaskOpts={{
        mask: Number,
        scale: 8,
        autofix: true,
        normalizeZeros: true,
        min: 0,
        radix: getDecimalSeparator(),
        mapToRadix: [",", "."],
      }}
      on:input={handleInput}
    >
      <span slot="end-icon">
        <Tooltip side="bottom">
          <button slot="trigger" class="swap-button" on:click={handleSwap}>
            <Swap size={24} />
          </button>
          <div slot="content">Swap between SATS and BTC</div>
        </Tooltip>
      </span>
    </Input>
  {/if}

  {#if currentCurrency === "SATS"}
    <Input
      {placeholder}
      value={satsValue}
      imaskOpts={{
        mask: Number,
        scale: 0,
        autofix: true,
        normalizeZeros: true,
        min: 0,
      }}
      on:input={handleInput}
    >
      <span slot="end-icon">
        <Tooltip side="bottom">
          <button slot="trigger" class="swap-button" on:click={handleSwap}>
            <Swap size={24} />
          </button>
          <div slot="content">Swap between SATS and BTC</div>
        </Tooltip>
      </span>
    </Input>
  {/if}
</InputWithLabel>

<style lang="scss">
  .swap-button {
    border: unset;
    background-color: transparent;
    color: var(--uni-on-bg);
    cursor: pointer;
  }

  .swap-button:hover {
    color: var(--uni-primary);
  }
</style>
