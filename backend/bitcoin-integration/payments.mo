import Bip32 "bip32";

import Result "mo:base/Result";
import Option "mo:base/Option";

import Types "types";
import Converter "converter";

module {
  type Network = Types.Network;

  public func generatePaymentAddress(base58Key : [Nat8], childrenIndex : Nat32, network : Network) : Result.Result<Text, Text> {
    switch (Bip32.getBip32FromBase58(base58Key, network)) {
      case (#err(err)) { #err(err) };
      case (#ok(null)) {
        #err("Unable to retrieve Bip32 from Base58 string.");
      };
      case (#ok(?val)) {
        switch (val.derive(0)) {
          case (#err(err)) { #err(err) };
          case (#ok(null)) {
            #err("Unable to derive child.");
          };
          case (#ok(?child)) {
            switch (child.derive(childrenIndex % 30)) {
              case (#err(err)) { #err(err) };
              case (#ok(null)) {
                #err("Unable to derive grand child.");
              };
              case (#ok(?grandChild)) {
                let p2wpkh = Converter.converToP2WPKH(Option.get(grandChild.getPublicKey(), []));

                let address = Converter.convertToBech32Address(p2wpkh, network);

                return #ok(address);
              };
            };
          };
        };
      };
    };
  };
};
