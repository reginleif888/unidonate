<script lang="ts">
  import { onMount } from "svelte";

  export let codeValue: string;
  export let squareSize: number;
  export let id: string;

  let qrcode;

  onMount(() => {
    let script = document.createElement("script");
    script.src =
      "https://cdn.rawgit.com/davidshimjs/qrcodejs/gh-pages/qrcode.min.js";
    document.head.append(script);

    script.onload = function () {
      qrcode = new window.QRCode(id, {
        text: codeValue,
        width: squareSize,
        height: squareSize,
        colorDark: "#000000",
        colorLight: "#ffffff",
        correctLevel: window.QRCode.CorrectLevel.H,
      });
    };
  });
</script>

<div {id} style={`height: ${squareSize}px`}></div>

<style>
  #qrcode {
    width: 20px;
    height: 200x;
    margin-top: 15px;
  }
</style>
