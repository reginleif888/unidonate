import Result "mo:base/Result";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Nat8 "mo:base/Nat8";
import Prelude "mo:base/Prelude";
import Text "mo:base/Text";

module {
  /// Returns the hexadecimal representation of a `Nat8` considered as a `Nat4`.
  func nat4ToText(nat4 : Nat8) : Text {
    Text.fromChar(
      switch nat4 {
        case 0 '0';
        case 1 '1';
        case 2 '2';
        case 3 '3';
        case 4 '4';
        case 5 '5';
        case 6 '6';
        case 7 '7';
        case 8 '8';
        case 9 '9';
        case 10 'a';
        case 11 'b';
        case 12 'c';
        case 13 'd';
        case 14 'e';
        case 15 'f';
        case _ Prelude.unreachable();
      }
    );
  };

  /// Returns the hexadecimal representation of a `Nat8`.
  func nat8ToText(byte : Nat8) : Text {
    let leftNat4 = byte >> 4;
    let rightNat4 = byte & 15;
    nat4ToText(leftNat4) # nat4ToText(rightNat4);
  };

  /// Returns the hexadecimal representation of a byte array.
  public func bytesToText(bytes : [Nat8]) : Text {
    Text.join("", Iter.map<Nat8, Text>(Iter.fromArray(bytes), func(n) { nat8ToText(n) }));
  };
};
