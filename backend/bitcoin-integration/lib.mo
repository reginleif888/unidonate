import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Nat64 "mo:base/Nat64";
import Iter "mo:base/Iter";
import Result "mo:base/Result";
import Option "mo:base/Option";

import BitcoinTypes "mo:motoko-bitcoin/bitcoin/Types";
import Base58Check "mo:motoko-bitcoin/Base58Check";

import BitcoinApi "./bitcoin-api";
import Utils "./utils";
import Types "./types";
import NetworkConfig "./network";
import Payments "./payments";

module {
  public type GetUtxosResponse = Types.GetUtxosResponse;
  public type Network = Types.Network;
  public type BitcoinAddress = Types.BitcoinAddress;
  public type Satoshi = Types.Satoshi;

  private func getUtxos(address : BitcoinAddress) : async* GetUtxosResponse {
    await BitcoinApi.getUtxos(NetworkConfig.config.network, address);
  };

  private func parseTransactionId(transactionId : Blob) : Text {
    Utils.bytesToText(Array.reverse(Blob.toArray(transactionId)));
  };

  public func generateNextPaymentAddress(ownerExtendedPublicKeyBase58Check : Text, currentChildKeyIndex : Nat32) : ?Text {
    let decoded = Base58Check.decode(ownerExtendedPublicKeyBase58Check);

    if (decoded == null) {
      return null;
    };

    switch (Payments.generatePaymentAddress(Option.get<[Nat8]>(decoded, []), currentChildKeyIndex, NetworkConfig.config.network)) {
      case (#err(msg)) { return null };
      case (#ok(val)) { return ?val };
    };
  };

  public func checkIfTransactionIsConfirmed(address : BitcoinAddress, transactionIdToCheck : Text, amount : Satoshi) : async Bool {
    let utxoResponse = await* getUtxos(address);

    for (utxo in utxoResponse.utxos.vals()) {
      let transactionId = parseTransactionId(utxo.outpoint.txid);

      if (transactionId == transactionIdToCheck and utxo.value == amount) {
        return true;
      };
    };

    return false;
  };
};
