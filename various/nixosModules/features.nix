{ lib, ... }:

let
  mkFeature = description: lib.mkOption {
    type = lib.types.str;
    description = "The chosen ${description}.";
    default = null;
  };

  mkBoolFeature = description: lib.mkOption {
    type = lib.types.bool;
    description = "Whether ${description} is being used.";
  };

in {
  options.features = {
    desktop = mkFeature "desktop environment";
    prompt = mkFeature "shell prompt";
    editor = mkFeature "editor";
    browser = mkFeature "browser";
    terminal = mkFeature "terminal";
    files = mkFeature "file manager";
    pdfs = mkFeature "PDF viewer";
    images = mkFeature "image viewer";
    videos = mkFeature "video viewer";

    usingKittab = mkBoolFeature "kittab";
  };
}
