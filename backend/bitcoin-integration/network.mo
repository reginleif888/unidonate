import Types "./types";

module {
  type Network = Types.Network;

  public type Config = {
    network : Network;
  };

  public let config : Config = {
    network = #Testnet;
  };
};
