<svelte:options immutable />

<script>
  import { onMount } from "svelte";
  import anime from "animejs";

  const num = 120;

  const vw = Math.max(
    document.documentElement.clientWidth,
    window.innerWidth || 0
  );

  const vh = Math.max(
    document.documentElement.clientHeight,
    window.innerHeight || 0
  );

  const getRandomX = () => {
    return Math.floor(Math.random() * Math.floor(vw)).toString();
  };

  const getRandomY = () => {
    return Math.floor(Math.random() * Math.floor(vh)).toString();
  };

  const randomRadius = () => {
    return Math.random() * 0.7 + 0.6;
  };

  const starryNight = () => {
    anime({
      targets: ["#sky .star"],
      opacity: [
        {
          duration: 700,
          value: "0",
        },
        {
          duration: 700,
          value: "1",
        },
      ],
      easing: "linear",
      loop: true,
      delay: (el, i) => 10 * i,
    });
  };

  const shootingStars = () => {
    anime({
      targets: ["#shootingstars .wish"],
      easing: "linear",
      loop: true,
      delay: (el, i) => 500 * i,
      opacity: [
        {
          duration: 700,
          value: "1",
        },
      ],
      width: [
        {
          value: "150px",
        },
        {
          value: "0px",
        },
      ],
      translateX: 350,
    });
  };

  onMount(() => {
    starryNight();
    shootingStars();
  });
</script>

<div id="animation">
  <svg id="sky">
    {#each [...Array(num)] as x, y (y)}
      <circle
        cx={getRandomX()}
        cy={getRandomY()}
        r={randomRadius()}
        stroke="none"
        stroke-width="0"
        fill="white"
        class="star"
      />
    {/each}
  </svg>
  <div id="shootingstars">
    {#each [...Array(60)] as x, y (y)}
      <div class="wish" style="left: {getRandomY()}px; top: {getRandomX()}px" />
    {/each}
  </div>
</div>

<style>
  #animation {
    position: absolute;
    top: 0;
    bottom: 0;
  }

  #sky {
    width: 100vw;
    height: 100vh;
    position: absolute;
    overflow: hidden;
    margin: 0;
    padding: 0;
  }

  #shootingstars {
    margin: 0;
    padding: 0;
    width: 150vh;
    height: 100vw;
    position: absolute;
    overflow: hidden;
    transform: translateX(calc(50vw - 50%)) translateY(calc(50vh - 50%))
      rotate(120deg);
  }

  .wish {
    height: 2px;
    top: 300px;
    width: 100px;
    margin: 0;
    opacity: 0;
    padding: 0;
    background-color: white;
    position: absolute;
    background: linear-gradient(-45deg, white, rgba(0, 0, 255, 0));
    filter: drop-shadow(0 0 6px white);
    overflow: hidden;
  }
</style>
