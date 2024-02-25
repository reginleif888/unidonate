import Array "mo:base/Array";
import ExperimentalStableMemory "mo:base/ExperimentalStableMemory";
import Nat64 "mo:base/Nat64";
import Blob "mo:base/Blob";
import Nat32 "mo:base/Nat32";
import Region "mo:base/Region";
import Option "mo:base/Option";
import Iter "mo:base/Iter";

import Types "../types";

module {
  private let MEMORY_SHIFT : Nat64 = 4;

  public func storeBlobImageInMemory(imageBlob : Blob, memoryOffset : Nat64) : {
    imageSize : Nat;
    shift : Nat64;
  } {
    let size = Nat32.toNat(Nat32.fromIntWrap(imageBlob.size()));

    let currentPages = ExperimentalStableMemory.size();

    let pagesRequiredToStoreBlob = (Nat64.toNat(memoryOffset + Nat64.fromNat(size)) / 65536) + 1;

    if (Nat64.toNat(currentPages) < pagesRequiredToStoreBlob) {
      ignore ExperimentalStableMemory.grow(Nat64.fromNat(pagesRequiredToStoreBlob) - currentPages);
    };

    ExperimentalStableMemory.storeBlob(memoryOffset, imageBlob);

    return { imageSize = size; shift = MEMORY_SHIFT };
  };

  public func processImageDeletion(imagesData : [Types.ImageObject], onShift : ({ id : Text; newOffset : Nat64 }) -> ()) : Nat64 {
    let imagesToDelete = imagesData
    |> Array.filter<Types.ImageObject>(_, func(data) { data.isDeleted })
    |> Array.sort<Types.ImageObject>(_, func(a, b) { Nat64.compare(a.offset, b.offset) });

    let startOffset = imagesToDelete[0].offset;

    let imagesToShift = imagesData
    |> Array.filter<Types.ImageObject>(_, func(data) { not data.isDeleted and data.offset > startOffset })
    |> Array.sort<Types.ImageObject>(_, func(a, b) { Nat64.compare(a.offset, b.offset) });

    var newOffset = startOffset;

    for (imageData in Iter.fromArray(imagesToShift)) {
      ExperimentalStableMemory.storeBlob(newOffset, ExperimentalStableMemory.loadBlob(imageData.offset, imageData.size));
      onShift({ id = imageData.id; newOffset = newOffset });
      newOffset += Nat64.fromNat(imageData.size) + MEMORY_SHIFT;
    };

    return newOffset;
  };

  public func getBlobImageFromMemory(offset : Nat64, size : Nat) : ?Blob {
    return ?ExperimentalStableMemory.loadBlob(offset, size);
  };
};
