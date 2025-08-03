import { describe, it, expect, beforeEach } from "vitest";

interface ThreadlyNFTMock {
  admin: string;
  totalSupply: number;
  tokenOwner: Map<number, string>;
  tokenURI: Map<number, string>;
  tokenRoyalty: Map<number, string>;
  mint: (caller: string, recipient: string, uri: string, creator: string) => { value?: number; error?: number };
  transfer: (caller: string, tokenId: number, to: string) => { value?: boolean; error?: number };
  burn: (caller: string, tokenId: number) => { value?: boolean; error?: number };
  updateURI: (caller: string, tokenId: number, newURI: string) => { value?: boolean; error?: number };
  payoutRoyalty: (tokenId: number, amount: number) => { recipient?: string; amount?: number; error?: number };
}

let mockContract: ThreadlyNFTMock;

beforeEach(() => {
  mockContract = {
    admin: "ST1ADMIN...",
    totalSupply: 0,
    tokenOwner: new Map(),
    tokenURI: new Map(),
    tokenRoyalty: new Map(),

    mint(caller, recipient, uri, creator) {
      if (caller !== this.admin) return { error: 100 };
      const tokenId = this.totalSupply + 1;
      this.tokenOwner.set(tokenId, recipient);
      this.tokenURI.set(tokenId, uri);
      this.tokenRoyalty.set(tokenId, creator);
      this.totalSupply = tokenId;
      return { value: tokenId };
    },

    transfer(caller, tokenId, to) {
      const owner = this.tokenOwner.get(tokenId);
      if (!owner) return { error: 103 };
      if (caller !== owner) return { error: 101 };
      this.tokenOwner.set(tokenId, to);
      return { value: true };
    },

    burn(caller, tokenId) {
      const owner = this.tokenOwner.get(tokenId);
      if (!owner) return { error: 103 };
      if (caller !== owner) return { error: 101 };
      this.tokenOwner.delete(tokenId);
      this.tokenURI.delete(tokenId);
      this.tokenRoyalty.delete(tokenId);
      return { value: true };
    },

    updateURI(caller, tokenId, newURI) {
      if (caller !== this.admin) return { error: 100 };
      if (!this.tokenOwner.get(tokenId)) return { error: 103 };
      this.tokenURI.set(tokenId, newURI);
      return { value: true };
    },

    payoutRoyalty(tokenId, amount) {
      const creator = this.tokenRoyalty.get(tokenId);
      if (!creator) return { error: 105 };
      return { recipient: creator, amount };
    }
  };
});

describe("Threadly NFT Contract", () => {
  it("should mint a new NFT", () => {
    const result = mockContract.mint(mockContract.admin, "ST2USER...", "ipfs://metadata1", "ST3CREATOR...");
    expect(result.value).toBe(1);
    expect(mockContract.tokenOwner.get(1)).toBe("ST2USER...");
  });

  it("should transfer NFT ownership", () => {
    mockContract.mint(mockContract.admin, "ST2USER...", "ipfs://metadata1", "ST3CREATOR...");
    const result = mockContract.transfer("ST2USER...", 1, "ST4USER...");
    expect(result.value).toBe(true);
    expect(mockContract.tokenOwner.get(1)).toBe("ST4USER...");
  });

  it("should burn NFT", () => {
    mockContract.mint(mockContract.admin, "ST2USER...", "ipfs://metadata1", "ST3CREATOR...");
    const result = mockContract.burn("ST2USER...", 1);
    expect(result.value).toBe(true);
    expect(mockContract.tokenOwner.has(1)).toBe(false);
  });

  it("should update token URI", () => {
    mockContract.mint(mockContract.admin, "ST2USER...", "ipfs://metadata1", "ST3CREATOR...");
    const result = mockContract.updateURI(mockContract.admin, 1, "ipfs://newmetadata");
    expect(result.value).toBe(true);
    expect(mockContract.tokenURI.get(1)).toBe("ipfs://newmetadata");
  });

  it("should payout royalty to creator", () => {
    mockContract.mint(mockContract.admin, "ST2USER...", "ipfs://metadata1", "ST3CREATOR...");
    const payout = mockContract.payoutRoyalty(1, 1000);
    expect(payout.recipient).toBe("ST3CREATOR...");
    expect(payout.amount).toBe(1000);
  });
});
