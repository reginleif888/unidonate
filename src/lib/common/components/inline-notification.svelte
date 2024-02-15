<script lang="ts">
  export let type: "error" | "success" | "warning" | "info" = "error";

  export let title: string;
  export let message: string;
</script>

<div
  class="inline-notification-root"
  class:error={type === "error"}
  class:success={type === "success"}
  class:warning={type === "warning"}
  class:info={type === "info"}
>
  <span class="subtitle1">{title}</span>
  <span class="subtitle2">{message}</span>
</div>

<style>
  .subtitle1 {
    font-weight: 700;
  }

  .inline-notification-root {
    position: relative;
    display: flex;
    align-items: flex-start;
    flex-direction: column;
    gap: 8px;
    padding: 8px;
    border: 1px solid var(--divider-color);
    background-color: var(--primary-bg);
    border-color: var(--primary-bg);
    color: var(--error-color);
    padding: 16px;
    width: 100%;
  }

  .inline-notification-root::before {
    content: "";
    position: absolute;
    left: 0px;
    top: 0px;
    bottom: 0px;
    height: 100%;
    width: 4px;
  }

  .error {
    background-color: var(--error-bg);
  }

  .error::before {
    background-color: var(--error-color);
  }

  .success {
    background-color: var(--success-bg);
  }

  .success::before {
    background-color: var(--success-color);
  }

  .warning {
    background-color: var(--warning-bg);
  }

  .warning::before {
    background-color: var(--warning-color);
  }

  .info {
    background-color: var(--info-bg);
  }

  .info::before {
    background-color: var(--info-color);
  }
</style>
