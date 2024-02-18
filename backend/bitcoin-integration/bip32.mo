import Types "types";
import Network "network";
import Ecc "ecc";

import Field "mo:motoko-bitcoin/ec/Field";
import Jacobi "mo:motoko-bitcoin/ec/Jacobi";
import Common "mo:motoko-bitcoin/Common";
import Curves "mo:motoko-bitcoin/ec/Curves";
import Hmac "mo:motoko-bitcoin/Hmac";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Result "mo:base/Result";
import Option "mo:base/Option";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";

module {
    public type Network = Types.Network;

    public type Keys = {
        bip32Public : Nat32;
        bip32Private : Nat32;
    };

    let curve : Curves.Curve = Curves.secp256k1;

    public func getKeys(network : Network) : Keys {
        let keys = switch (network) {
            case (#Mainnet) {
                {
                    bip32Public : Nat32 = 0x0488b21e;
                    bip32Private : Nat32 = 0x0488ade4;
                };
            };
            case (#Testnet or #Regtest) {
                {
                    bip32Public : Nat32 = 0x043587cf;
                    bip32Private : Nat32 = 0x04358394;
                };
            };
        };
    };

    public func getBip32FromBase58(base58 : [Nat8], network : Network) : Result.Result<?BIP32, Text> {
        let keys = getKeys(network);

        let version = Common.readBE32(base58, 0);
        if (version != keys.bip32Public and version != keys.bip32Private) {
            return #err("Invalid network version");
        };

        let depth = base58[4];
        let parentFingerPrint = Common.readBE32(base58, 5);
        if (depth == 0 and parentFingerPrint != 0x00000000) {
            return #err("Invalid parent fingerprint");
        };

        let index = Common.readBE32(base58, 9);
        if (depth == 0 and index != 0) {
            return #err("Invalid index");
        };

        let chainCode = Iter.toArray(Array.slice(base58, 13, 45));

        var root : ?BIP32 = null;

        if (version == keys.bip32Private) {
            if (base58[45] != 0x00) {
                return #err("Invalid private key");
            };
            let privateKey = Iter.toArray(Array.slice(base58, 46, 78));
            if (not Ecc.isPrivate(privateKey)) {
                return #err("Private key not in range [1, n)");
            };
            root := ?BIP32(?privateKey, null, chainCode, network, ?depth, ?index, ?parentFingerPrint);
        } else {
            let publicKey = Iter.toArray(Array.slice(base58, 45, 78));
            if (not Ecc.isPoint(publicKey)) {
                return #err("Point is not on the curve");
            };
            root := ?BIP32(null, ?publicKey, chainCode, network, ?depth, ?index, ?parentFingerPrint);
        };

        return #ok(root);
    };

    public class BIP32(_privateKey : ?[Nat8], _publicKey : ?[Nat8], _chainCode : [Nat8], _network : Network, _depth : ?Nat8, _index : ?Nat32, _parentFingerPrint : ?Nat32) {
        var privateKey = _privateKey;
        var publicKey = _publicKey;
        let chainCode = _chainCode;
        let network = _network;
        public let depth = Option.get<Nat8>(_depth, 0x00);
        public let index = Option.get<Nat32>(_index, 0x00000000);
        public let parentFingerPrint = Option.get<Nat32>(_parentFingerPrint, 0x00000000);

        public func getPublicKey() : ?[Nat8] {
            if (publicKey == null) {
                ignore do ? {
                    let ki : Nat = Common.readBE256(privateKey!, 0);
                    let parsedPoint = Jacobi.mulBase(ki, curve);
                    publicKey := ?Jacobi.toBytes(parsedPoint, true);
                };
            };
            return publicKey;
        };

        public func getPrivateKey() : ?[Nat8] {
            return publicKey;
        };

        public func isNeutered() : Bool {
            return privateKey == null;
        };

        public func derive(index : Nat32) : Result.Result<?BIP32, Text> {
            let isHardened : Bool = index >= 0x80000000;

            let data : [var Nat8] = Array.tabulateVar<Nat8>(37, func _ { 0x00 });

            if (isHardened) {
                if (isNeutered()) {
                    return #err("Missing private key for hardened child key");
                };

                data[0] := 0x00;
                ignore do ? {
                    Common.copy(data, 1, privateKey!, 0, Array.size(privateKey!));
                };

                Common.writeBE32(data, 33, index);
            } else {
                ignore do ? {
                    Common.copy(data, 0, getPublicKey()!, 0, Array.size(getPublicKey()!));
                };
                Common.writeBE32(data, 33, index);
            };

            let hmacSha512 : Hmac.Hmac = Hmac.sha512(chainCode);
            hmacSha512.write(Array.freeze(data));
            let fullNode : [Nat8] = hmacSha512.sum();

            // Split HMAC output into two 32-byte sequences.
            let left : [Nat8] = Array.tabulate<Nat8>(32, func(i) { fullNode[i] });
            let right : [Nat8] = Array.tabulate<Nat8>(32, func(i) { fullNode[i + 32] });

            if (not Ecc.isPrivate(left)) {
                return derive(index + 1);
            };

            var root : ?BIP32 = null;

            if (not isNeutered()) {
                ignore do ? {
                    let il : Nat = Common.readBE256(left, 0);
                    let ki : Nat = Common.readBE256(privateKey!, 0);

                    let privateAdd = Field.add(il, ki, curve.r);

                    var num = privateAdd;
                    var bytes : Buffer.Buffer<Nat8> = Buffer.Buffer<Nat8>(0);
                    while (num > 0) {
                        let byte = Nat8.fromNat(num % 256);

                        bytes.add(byte);

                        num := num / 256;
                    };

                    let reversedBytes = Array.reverse(Buffer.toArray(bytes));
                    if (Array.size(reversedBytes) == 0) {
                        return derive(index + 1);
                    };
                    root := ?BIP32(?reversedBytes, null, right, network, ?(depth + 1), ?index, ?parentFingerPrint);
                };
            } else {
                ignore do ? {
                    let il : Nat = Common.readBE256(left, 0);

                    switch (Jacobi.fromBytes(getPublicKey()!, curve)) {
                        case (null) {
                            return #err("Invalid public key");
                        };
                        case (?parsedKey) {
                            // Derive the child public key.
                            switch (Jacobi.add(parsedKey, Jacobi.mulBase(il, curve))) {
                                case (#infinity(_)) {
                                    return derive(index + 1);
                                };
                                case (childParsedKey) {
                                    let keyInBytes = Jacobi.toBytes(childParsedKey, true);
                                    root := ?BIP32(null, ?keyInBytes, right, network, ?(depth + 1), ?index, ?parentFingerPrint);
                                };
                            };
                        };
                    };
                };
            };

            return #ok(root);
        };
    };

};
