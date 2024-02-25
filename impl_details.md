![github-header](https://github.com/reginleif888/unidonate/assets/154005444/d36f933e-579e-44c5-b438-1a128773f33e)

## UniDonate - Overview

The solution represents a decentralized system designed for public donations through Bitcoin. All components of the system are 100% on-chain powered by the [Internet Computer](https://internetcomputer.org/). To interact with the Bitcoin network, the system internally leverages [IC Bitcoin integration](https://wiki.internetcomputer.org/wiki/Bitcoin_Integration). All backend and smart contracts are written in Motoko. For the frontend part, SveltKit was chosen. At the moment, the system only interacts with the testnet Bitcoin network due to current limitations.

## Features

### Backend features

- Bitcoin integration
- Image on-chain storage
- Optimizations, sorting indexing
- Authorization for admin
- Schools & students management (admin)
- Owners management (admin)

### Frontend features

- SvelteKit, TypeScript
- Bits UI components
- Mobile-first responsive layout
- Light/dark themes
- Assets optimization
- Import from CSV/XLSX

## Some notes

### Bitcoin integration

We have written an algorithm that allows us to create Hierarchical Deterministic (HD) wallets based on both an extended public and an extended private keys. For each transaction we generate a new HD wallet (maximum 20). This approach allows to make the mechanism of interaction with Bitcoin more convenient and secure. Verification is carried out using the capabilities of Bitcoin integration of the Internet Computer.

### Image on-chain storage

We have implemented a mechanism that allows us to store and modify images entirely on the blockchain using [Stable Memory](https://internetcomputer.org/docs/current/motoko/main/stablememory). Offsets inside the Stable Memory for each image are saved, and then when the images are deleted, they move. To make the process of deleting images invisible to the user, we schedule the deletion, and then simply delete unnecessary images in the background and move the remaining images to free up memory for new images.
