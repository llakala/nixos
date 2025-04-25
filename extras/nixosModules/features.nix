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

    files = mkFeature "file manager";

    pdfs = mkFeature "PDF viewer";

    images = mkFeature "image viewer";

    videos = mkFeature "video viewer";

    discord = mkFeature "Discord client";

    math = mkFeature "math notes";

    usingKittab = mkBoolFeature "kittab";

    taskbar = lib.mkOption {
      type = with lib.types; listOf str;
      description = "The default desktop files for the taskbar";
    };
  };
}
