import Array "mo:base/Array";
import ExperimentalStableMemory "mo:base/ExperimentalStableMemory";
import Nat64 "mo:base/Nat64";
import Blob "mo:base/Blob";
import Nat32 "mo:base/Nat32";
import Region "mo:base/Region";
import Option "mo:base/Option";
import Iter "mo:base/Iter";

module {
  public type ImageData = {
    id : Text;
    offset : Nat64;
    size : Nat;
    isDeleted : Bool;
  };

  private let MEMORY_SHIFT : Nat64 = 4;

  public func storeBlobImageInMemory(imageBlob : Blob, memoryOffset : Nat64) : {
    imageSize : Nat;
    shift : Nat64;
  } {
    let size = Nat32.toNat(Nat32.fromIntWrap(imageBlob.size()));

    let currentPages = ExperimentalStableMemory.size();

    let pagesAfterGrow = (Nat64.toNat(memoryOffset + Nat64.fromNat(size)) / 65536) + 1;

    if (Nat64.toNat(currentPages) < pagesAfterGrow) {
      ignore ExperimentalStableMemory.grow(Nat64.fromNat(pagesAfterGrow) - currentPages);
    };

    ExperimentalStableMemory.storeBlob(memoryOffset, imageBlob);

    return { imageSize = size; shift = MEMORY_SHIFT };
  };

  public func processAndShiftForDeletedImagesInMemory(imagesData : [ImageData], onShift : ({ id : Text; newOffset : Nat64 }) -> ()) : Nat64 {
    let imagesToDelete = imagesData
    |> Array.filter<ImageData>(_, func(data) { data.isDeleted })
    |> Array.sort<ImageData>(_, func(a, b) { Nat64.compare(a.offset, b.offset) });

    let startOffset = imagesToDelete[0].offset;

    let imagesToShift = imagesData
    |> Array.filter<ImageData>(_, func(data) { not data.isDeleted and data.offset > startOffset })
    |> Array.sort<ImageData>(_, func(a, b) { Nat64.compare(a.offset, b.offset) });

    var temporaryOffset = startOffset;

    for (imageData in Iter.fromArray(imagesToShift)) {
      ExperimentalStableMemory.storeBlob(temporaryOffset, ExperimentalStableMemory.loadBlob(imageData.offset, imageData.size));
      onShift({ id = imageData.id; newOffset = temporaryOffset });
      temporaryOffset += Nat64.fromNat(imageData.size) + MEMORY_SHIFT;
    };

    return temporaryOffset;
  };

  public func getBlobImageFromMemory(offset : Nat64, size : Nat) : ?Blob {
    return ?ExperimentalStableMemory.loadBlob(offset, size);
  };
};
