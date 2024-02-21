import { writable } from "svelte/store";
import { AuthClient } from "@dfinity/auth-client";

const authClientStore = writable<AuthClient | null>(null);

export default authClientStore;
