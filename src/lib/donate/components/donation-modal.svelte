<script>
  import { Button, Modal, QrCode } from "$lib/common/components";
</script>

<Modal>
  <div class="inner">
    <div class="header">
      <h2>Donate</h2>
    </div>

    <div class="content">
      <QrCode
        id="donation"
        squareSize={260}
        codeValue="https://www.google.de/"
      />
      <p>You are about to donate to</p>
    </div>

    <div class="footer">
      <Button label="Ok, got it" contained fullWidth />
    </div>
  </div>
</Modal>

<style>
  .inner {
    padding: 24px;
    background-color: var(--uni-bg);
    box-shadow: var(--uni-shadow-paper);
    border-radius: 24px;
  }

  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
  }

  .content {
    margin-bottom: 24px;
  }

  .footer {
    display: flex;
    justify-content: flex-end;
  }
</style>
