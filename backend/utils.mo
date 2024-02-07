import Text "mo:base/Text";
import Char "mo:base/Char";
import Blob "mo:base/Blob";
import Principal "mo:base/Principal";
import Array "mo:base/Array";

import Types "./types";

module {
  type HttpResponse = Types.HttpResponse;

  // A 200 Ok response with picture
  public func picture(pic : Blob) : HttpResponse {
    {
      body = pic;
      headers = [
        ("Content-Type", "image/jpg"),
        ("Access-Control-Allow-Origin", "*")
        //("Expires", "Wed, 9 Jan 2099 09:09:09 GMT")
      ];
      status_code = 200;
      streaming_strategy = null;
    };
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
