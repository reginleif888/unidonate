import { writable } from "svelte/store";

const burgerMenu = writable<boolean>(false);

export default burgerMenu;
