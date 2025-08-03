# Threadly

A blockchain-powered fashion platform that bridges **physical fashion** with **virtual wearables**, allowing users to **own, wear, trade, and rent fashion items** in both the real and digital world — all on-chain.

---

## Overview

Threadly consists of ten main smart contracts that together create a **decentralized, verifiable, and monetizable ecosystem for fashion and digital wearables**:

1. **NFT Minting Contract** – Mints NFTs representing physical + virtual fashion items.  
2. **Metadata & AR Linking Contract** – Connects NFTs to AR and metaverse-compatible assets.  
3. **Purchase & Redemption Contract** – Handles buying NFTs and redeeming the physical items.  
4. **Rental Contract** – Enables short-term rental of virtual fashion items.  
5. **Marketplace Contract** – Facilitates peer-to-peer resale and trade of NFTs.  
6. **Royalty & Revenue Split Contract** – Automatically distributes royalties to brands/designers.  
7. **Physical Verification Contract** – Ensures authenticity of physical items during resale.  
8. **User Identity & Wallet Linking Contract** – Links wallets to AR/metaverse profiles securely.  
9. **Cross-Platform Interoperability Contract** – Bridges wearables across different metaverse platforms.  
10. **Loyalty & Rewards Contract** – Incentivizes active users with points or tokens.  

---

## Features

- **Dual ownership** of physical and digital wearables  
- **AR try-on support** for shopping and metaverse avatars  
- **Verified authenticity** of fashion items on-chain  
- **NFT rental system** for digital event outfits  
- **Secondary marketplace** with built-in royalties  
- **Cross-platform wearable compatibility** in the metaverse  
- **Automatic revenue split** for brands and designers  
- **User loyalty rewards** for engagement and activity  

---

## Smart Contracts

### NFT Minting Contract
- Mints NFTs representing physical + digital fashion pieces  
- Supports batch minting for collections  
- Includes ownership tracking and burn functionality  

### Metadata & AR Linking Contract
- Stores AR asset links and 3D files for virtual try-on  
- Updates metadata for metaverse integration  
- Verifies digital asset authenticity  

### Purchase & Redemption Contract
- Processes NFT purchases with native or stable tokens  
- Allows redemption of physical items linked to NFTs  
- Logs redemption history on-chain  

### Rental Contract
- Lets users rent virtual items for a defined period  
- Holds security deposit in escrow  
- Automatically returns NFT access after rental expiry  

### Marketplace Contract
- Enables peer-to-peer resale and trading of NFTs  
- Enforces brand royalties on every sale  
- Provides transparent transaction history  

### Royalty & Revenue Split Contract
- Distributes revenue to designers, brands, and Threadly treasury  
- Handles multi-party royalty splits automatically  
- Maintains on-chain payout logs  

### Physical Verification Contract
- Links serial numbers or QR codes to NFTs  
- Validates authenticity for secondary sales  
- Prevents counterfeit items entering the ecosystem  

### User Identity & Wallet Linking Contract
- Connects user wallet to AR/metaverse profiles  
- Supports multiple avatar and game integrations  
- Manages user authentication without centralized storage  

### Cross-Platform Interoperability Contract
- Bridges NFTs to compatible metaverse platforms  
- Tracks external transfers to maintain provenance  
- Supports metadata adaptation for different engines  

### Loyalty & Rewards Contract
- Issues points or tokens for purchases, rentals, and engagement  
- Tracks user activity to unlock perks or discounts  
- Supports token redemption in Threadly ecosystem  

---

## Installation

1. Install [Clarinet CLI](https://docs.hiro.so/clarinet/getting-started)  
2. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/threadly.git
   ```
3. Run tests:
    ```bash
    npm test
    ```
4. Deploy contracts:
    ```bash
    clarinet deploy
    ```

---

## Usage

Each contract functions independently but interacts within the Threadly ecosystem to provide a seamless fashion experience.
Refer to individual contract docs for function calls, parameters, and usage examples.

---

## License

MIT License