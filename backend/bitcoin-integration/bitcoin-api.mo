import ExperimentalCycles "mo:base/ExperimentalCycles";

import Types "./types";

module {
  type Cycles = Types.Cycles;
  type Network = Types.Network;
  type BitcoinAddress = Types.BitcoinAddress;
  type GetUtxosResponse = Types.GetUtxosResponse;
  type GetUtxosRequest = Types.GetUtxosRequest;

  let GET_UTXOS_COST_CYCLES : Cycles = 10_000_000_000;

  type ManagementCanisterActor = actor {
    bitcoin_get_utxos : GetUtxosRequest -> async GetUtxosResponse;
  };

  let management_canister_actor : ManagementCanisterActor = actor ("aaaaa-aa");

  public func getUtxos(network : Network, address : BitcoinAddress) : async GetUtxosResponse {
    ExperimentalCycles.add(GET_UTXOS_COST_CYCLES);
    await management_canister_actor.bitcoin_get_utxos({
      address;
      network;
      filter = null;
    });
  };
};
