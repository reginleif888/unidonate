<script lang="ts">
  import { Prohibit, CheckCircle, WarningCircle, Info } from "phosphor-svelte";

  export let type: "error" | "success" | "warning" | "info" = "error";

  export let title: string;
  export let message: string;
  export let fullWidthText: boolean = false;

  const mapTypeToIcon = {
    error: {
      Component: Prohibit,
    },
    success: {
      Component: CheckCircle,
    },
    warning: {
      Component: WarningCircle,
    },
    info: {
      Component: Info,
    },
  };

  $: Component = mapTypeToIcon[type].Component;
</script>

<div
  class="inline-notification-root"
  class:inline-notification-root--error={type === "error"}
  class:inline-notification-root--success={type === "success"}
  class:inline-notification-root--warning={type === "warning"}
  class:inline-notification-root--info={type === "info"}
>
  <div
    class="inline-notification-root__text"
    class:inline-notification-root__full-width-text={fullWidthText}
  >
    <div class="inline-notification-root__title-wrapper">
      <span class="inline-notification-root__title subtitle1">{title}</span>
      <span
        class="inline-notification-root__icon"
        class:inline-notification-root__icon--error={type === "error"}
        class:inline-notification-root__icon--success={type === "success"}
        class:inline-notification-root__icon--warning={type === "warning"}
        class:inline-notification-root__icon--info={type === "info"}
      >
        <Component size={20} weight="bold" />
      </span>
    </div>
    <span class="subtitle2">{message}</span>
  </div>
  <slot name="end" />
</div>

<style lang="scss">
  .inline-notification-root {
    position: relative;
    display: flex;
    gap: 8px;
    padding: 8px;
    border: 1px solid var(--uni-divider-color);
    background-color: var(--uni-bg);
    color: var(--uni-on-bg);
    padding: 16px;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;

    &__text {
      max-width: 75%;
    }

    &__full-width-text {
      max-width: 100%;
    }

    &__title {
      font-weight: 700;
    }

    &__title-wrapper {
      display: flex;
      align-items: center;
      gap: 8px;
    }

    &__icon {
      &--error {
        color: var(--uni-error-color);
      }

      &--success {
        color: var(--uni-success-color);
      }

      &--warning {
        color: var(--uni-warning-color);
      }

      &--info {
        color: var(--uni-info-color);
      }
    }

    &::after {
      content: "";
      position: absolute;
      left: 0px;
      top: 0px;
      bottom: 0px;
      right: 0px;
      z-index: 1;
      pointer-events: none;
      opacity: 0.5;
    }

    &::before {
      content: "";
      position: absolute;
      left: 0px;
      top: 0px;
      bottom: 0px;
      height: 100%;
      width: 4px;
    }

    &--error::before {
      background-color: var(--uni-error-color);
    }

    &--success::before {
      background-color: var(--uni-success-color);
    }

    &--warning::before {
      background-color: var(--uni-warning-color);
    }

    &--info::before {
      background-color: var(--uni-info-color);
    }

    &--error::after {
      background-color: var(--uni-error-color);
      opacity: 0.2;
    }

    &--success::after {
      background-color: var(--uni-success-color);
      opacity: 0.2;
    }

    &--warning::after {
      background-color: var(--uni-warning-color);
      opacity: 0.2;
    }

    &--info::after {
      background-color: var(--uni-info-color);
      opacity: 0.2;
    }
  }
</style>
