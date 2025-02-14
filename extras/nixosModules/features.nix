{ lib, ... }:

let
  mkFeature = description: lib.mkOption
  {
    type = lib.types.str;
    description = "The chosen ${description}.";
    default = null;
  };

  mkBoolFeature = description: lib.mkOption
  {
    type = lib.types.bool;
    description = "Whether ${description} is being used.";
  };

in
{
  options.features =
  {
    shell = mkFeature "shell, which provides some form of initExtra access";

    desktop = mkFeature "desktop environment";

    prompt = mkFeature "shell prompt";

    editor = mkFeature "editor";

    abbreviations = mkFeature "provider of abbreviations";

    direnv = mkFeature "program for providing direnv functionality";

    browser = mkFeature "browser";

    terminal = mkFeature "terminal";

    fileManager = mkFeature "file manager";

    pdfViewer = mkFeature "PDF viewer";

    imageViewer = mkFeature "image viewer";

    videoViewer = mkFeature "video viewer";

    usingKittab = mkBoolFeature "kittab";
  };
}
