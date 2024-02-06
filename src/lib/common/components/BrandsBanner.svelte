<div class="container">
  <div class="image-container">
    <img src="/icons/donut_icon.svg" alt="Logo" class="logo" />
  </div>
  <div class="image-container">
    <img src="/icons/ic.svg" alt="Logo" class="logo" />
  </div>
</div>

<style>
  .container {
    position: relative;
    width: 100%;
    height: 200px;
    overflow: hidden;
    background-color: var(--secondary-bg);
    display: flex;
    justify-content: space-between;
    background-image: url("/images/checkerboard_pattern_brand.png");
    background-size: 100px 100px;
    background-repeat: repeat;
    background-attachment: fixed;
  }

  .logo {
    width: 50%;
    height: 160px;
  }

  .image-container {
    position: absolute;
    display: flex;
    justify-content: space-between;
    animation: slide 6s linear infinite;
    height: 100px;
    width: 50%;
    top: 50%;
    transform: translateY(-75%);
  }

  .image-container:nth-child(1) {
    animation-delay: 3s;
  }

  @keyframes slide {
    from {
      right: -100%;
    }
    to {
      right: 100%;
    }
  }
</style>
