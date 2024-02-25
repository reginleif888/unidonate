import Text "mo:base/Text";
import Char "mo:base/Char";
import Blob "mo:base/Blob";
import Principal "mo:base/Principal";
import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Vector "mo:vector/Class";
import List "mo:base/List";
import RBTree "mo:base/RBTree";

import Types "./types";

module {
  type HttpResponse = Types.HttpResponse;

  // A 200 Ok response with picture
  public func picture(pic : Blob) : HttpResponse {
    {
      body = pic;
      headers = [
        ("Content-Type", "image/jpg"),
        ("Access-Control-Allow-Origin", "*"),
        ("Cache-Control", "public, max-age=3600, must-revalidate")
        //("Expires", "Wed, 9 Jan 2099 09:09:09 GMT")
      ];
      status_code = 200;
      streaming_strategy = null;
    };
  };

  public func mapAndSortTreeToRecords<Key, Record>(rbtree : RBTree.RBTree<Key, List.List<Nat>>, records : Vector.Vector<Record>, order : Types.DonationSortingOrder) : [Record] {
    let iterator = switch (order) {
      case (#descending) { rbtree.entriesRev() };
      case (#ascending) { rbtree.entries() };
    };

    return iterator |> Iter.toList(_)
    |> List.foldLeft<(Key, List.List<Nat>), List.List<Nat>>(
      _,
      null,
      func(acc, (_, indexes)) {
        List.append(
          acc,
          indexes,
        );
      },
    )
    |> List.map<Nat, Record>(
      _,
      func(index) {
        records.get(index);
      },
    )
    |> List.toArray(_);
  };

  // A 404 response with an optional error message.
  public func http404(msg : ?Text) : HttpResponse {
    {
      body = Text.encodeUtf8(
        switch (msg) {
          case (?msg) msg;
          case null "Not found.";
        }
      );
      headers = [("Content-Type", "text/plain")];
      status_code = 404;
      streaming_strategy = null;
    };
  };

};
