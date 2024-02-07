import Text "mo:base/Text";
import Blob "mo:base/Blob";
import Array "mo:base/Array";
import Nat64 "mo:base/Nat64";
import Iter "mo:base/Iter";
import Result "mo:base/Result";

import BitcoinTypes "mo:motoko-bitcoin/bitcoin/Types";

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

  public func generateNextPaymentAddress(ownerExtendedPublicKeyBase58Check : Text, currentChildKeyIndex : Nat) : async Result.Result<Text, Payments.GetDerivationError> {
    if (ownerExtendedPublicKeyBase58Check == "") {
      return #err(#OwnerExtendedPubKeyNotSet);
    };
    return switch (Payments.parse(ownerExtendedPublicKeyBase58Check, NetworkConfig.config.network)) {
      case null return #err(#Base58PubKeyWrongFormatError);
      case (?parsedPublicKey) {
        switch (parsedPublicKey.derivePath(Payments.getRelativePath(0))) {
          case null return #err(#ChildKeyDerivationError);
          case (?derivedFirstNonHardenedChild) {
            switch (derivedFirstNonHardenedChild.derivePath(Payments.getRelativePath(currentChildKeyIndex))) {
              case null return #err(#ChildKeyDerivationError);
              case (?derived) {
                let address : Text = Payments.getP2PKHAddress(derived.key, NetworkConfig.config.network);
                return #ok(address);
              };
            };
          };
        };
      };
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
