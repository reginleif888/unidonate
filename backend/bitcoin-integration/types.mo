module Types {
  public type Satoshi = Nat64;
  public type Cycles = Nat;
  public type BitcoinAddress = Text;
  public type BlockHash = [Nat8];
  public type Page = [Nat8];

  public type Network = {
    #Mainnet;
    #Testnet;
    #Regtest;
  };

  public type OutPoint = {
    txid : Blob;
    vout : Nat32;
  };

  public type Utxo = {
    outpoint : OutPoint;
    value : Satoshi;
    height : Nat32;
  };

  public type UtxosFilter = {
    #MinConfirmations : Nat32;
    #Page : Page;
  };

  public type GetUtxosRequest = {
    address : BitcoinAddress;
    network : Network;
    filter : ?UtxosFilter;
  };

  public type GetUtxosResponse = {
    utxos : [Utxo];
    tip_block_hash : BlockHash;
    tip_height : Nat32;
    next_page : ?Page;
  };
};
