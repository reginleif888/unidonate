import Array "mo:base/Array";
import ExperimentalStableMemory "mo:base/ExperimentalStableMemory";
import Nat64 "mo:base/Nat64";
import Blob "mo:base/Blob";
import Nat32 "mo:base/Nat32";
import Region "mo:base/Region";

module {
  private let MEMORY_SHIFT : Nat64 = 4;

  public func storeBlobImageInMemory(imageBlob : Blob, memoryOffset : Nat64) : {
    imageSize : Nat;
    shift : Nat64;
  } {
    let size = Nat32.toNat(Nat32.fromIntWrap(imageBlob.size()));

    let memoryGrow = (size / 65536) + 1;
    ignore ExperimentalStableMemory.grow(Nat64.fromNat(memoryGrow));
    ExperimentalStableMemory.storeBlob(memoryOffset, imageBlob);

    return { imageSize = size; shift = MEMORY_SHIFT };
  };

  public func getBlobImageFromMemory(offset : Nat64, size : Nat) : ?Blob {
    return ?ExperimentalStableMemory.loadBlob(offset, size);
  };
};
