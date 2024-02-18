import Curves "mo:motoko-bitcoin/ec/Curves";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";

module {
    let PRIVATE_KEY_SIZE : Nat = 32;
    let PUBLIC_KEY_COMPRESSED_SIZE : Nat = 33;
    let PUBLIC_KEY_UNCOMPRESSED_SIZE : Nat = 65;
    let X_ONLY_PUBLIC_KEY_SIZE : Nat = 32;

    let BN32_N : [Nat8] = [
        255,
        255,
        255,
        255,
        255,
        255,
        255,
        255,
        255,
        255,
        255,
        255,
        255,
        255,
        255,
        254,
        186,
        174,
        220,
        230,
        175,
        72,
        160,
        59,
        191,
        210,
        94,
        140,
        208,
        54,
        65,
        65,
    ];

    let curve : Curves.Curve = Curves.secp256k1;

    private func compareToBN32_N(key : [Nat8]) : Int {
        for (index in Iter.range(0, Array.size(key) - 1)) {
            if (key[index] > BN32_N[index]) {
                return 1;
            };

            if (key[index] < BN32_N[index]) {
                return -1;
            };
        };

        return 0;
    };

    private func compareToBN32_ZERO(key : [Nat8]) : Int {
        for (index in Iter.range(0, Array.size(key) - 1)) {
            if (key[index] > 0) {
                return 1;
            };

            if (key[index] < 0) {
                return -1;
            };
        };

        return 0;
    };

    public func isPrivate(privateKey : [Nat8]) : Bool {
        return Array.size(privateKey) == PRIVATE_KEY_SIZE and compareToBN32_N(privateKey) < 0 and compareToBN32_ZERO(privateKey) > 0;
    };

    public func isPoint(publicKey : [Nat8]) : Bool {
        return Array.size(publicKey) == PUBLIC_KEY_COMPRESSED_SIZE or Array.size(publicKey) == PUBLIC_KEY_UNCOMPRESSED_SIZE or Array.size(publicKey) == X_ONLY_PUBLIC_KEY_SIZE;
    };

};
