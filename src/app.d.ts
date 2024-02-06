// See https://kit.svelte.dev/docs/types#app
// for information about these interfaces
declare global {
  interface Window {
    QRCode: function | object;
  }

  namespace App {
    // interface Error {}
    // interface Locals {}
    // interface PageData {}
    // interface PageState {}
    // interface Platform {}
  }
}

declare module "svelte/elements" {
  export interface HTMLAttributes<T> {
    "on:clickoutside"?: (event: CustomEvent<T>) => void;
    "on:copysuccess"?: (event: CustomEvent<T>) => void;
    "on:copyerror"?: (event: CustomEvent<T>) => void;
  }
}

export {};
