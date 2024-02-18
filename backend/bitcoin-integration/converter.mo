import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Nat "mo:base/Nat";
import Base58Check "mo:motoko-bitcoin/Base58Check";
import Hash "mo:motoko-bitcoin/Hash";
import Bech32 "mo:motoko-bitcoin/Bech32";
import Ripemd160 "mo:motoko-bitcoin/Ripemd160";
import SHA256 "mo:sha/SHA256";

import Types "types";

module {
    type Network = Types.Network;

    private func getBech32HRP(network : Network) : Text {
        switch (network) {
            case (#Mainnet) { "bc" };
            case (#Testnet or #Regtest) { "tb" };
        };
    };

    private func encodeVersion(network : Network) : Nat8 {
        return switch (network) {
            case (#Mainnet) {
                0x00;
            };
            case (#Testnet or #Regtest) {
                0x6f;
            };
        };
    };

    public func converToP2WPKH(publicKey : [Nat8]) : [Nat8] {
        return Hash.hash160(publicKey);
    };

    public func getP2PKHAddress(compressedPubKey : [Nat8], network : Types.Network) : Text {
        let ripemd160Hash : [Nat8] = Ripemd160.hash(SHA256.sha256(compressedPubKey));
        let versionedHash : [Nat8] = Array.tabulate<Nat8>(
            ripemd160Hash.size() + 1,
            func(i) {
                if (i == 0) {
                    return encodeVersion(network);
                } else {
                    ripemd160Hash[i - 1];
                };
            },
        );
        return Base58Check.encode(versionedHash);
    };

    public func convertTo5BitWords(bytes : [Nat8]) : [Nat8] {
        // Combine all bytes into a single bit stream
        var bitStream : Buffer.Buffer<Bool> = Buffer.Buffer<Bool>(0);
        for (index in Iter.range(0, Array.size(bytes) - 1)) {
            // Expand each byte into its bit components and append to the bit stream
            for (i in Iter.range(0, 7)) {
                let bit = ((bytes[index] >> Nat8.fromNat(7 - i)) & 1) == 1;
                bitStream.add(bit);
            };
        };

        // Split the bit stream into 5-bit groups
        var fiveBitWords : Buffer.Buffer<Nat8> = Buffer.Buffer<Nat8>(0);
        var tempWord : Nat8 = 0;
        var bitCount = 0;
        let bits = Buffer.toArray(bitStream);
        for (index in Iter.range(0, Array.size(bits) - 1)) {
            // Shift tempWord left by 1 and add the current bit
            tempWord := (tempWord << 1) | (if (bits[index]) { 1 } else { 0 });
            bitCount += 1;

            // Every 5 bits, append to fiveBitWords and reset
            if (bitCount == 5) {
                fiveBitWords.add(tempWord);
                tempWord := 0;
                bitCount := 0;
            };
        };

        // Handle the last word if bitCount < 5 and there are remaining bits
        if (bitCount > 0) {
            // Left-align the last bits
            let lastWord = tempWord * Nat8.fromNat(Nat.pow(2, 5 - bitCount));
            fiveBitWords.add(lastWord);
        };

        return Buffer.toArray(fiveBitWords);
    };

    public func convertToBech32Address(p2wpkh : [Nat8], network : Network) : Text {
        let hrp = getBech32HRP(network);
        let witnessVersion : Nat8 = 0;

        let data = convertTo5BitWords(p2wpkh);

        let values = Array.append([witnessVersion], data);

        let address = Bech32.encode(hrp, values, #BECH32);

        return address;
    };

    public func covertP2WPKHTtoP2SH(p2wpkh : [Nat8]) : Text {
        let scriptPrefix : [Nat8] = [0x00, 0x14];
        let script = Array.append(scriptPrefix, p2wpkh);

        let newHash = Hash.hash160(script);

        let networkPrefix : [Nat8] = [0xc4];
        let prefixedHash = Array.append(networkPrefix, newHash);

        let address = Base58Check.encode(prefixedHash);

        return address;
    };
};
