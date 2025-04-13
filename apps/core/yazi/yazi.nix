{ lib, inputs, ... }:

{
  features.files = "yazi"; # Change if we ever stop using Yazi

  disabledModules = lib.singleton "programs/yazi.nix";
  imports = lib.singleton (inputs.nixpkgs-unstable + "/nixos/modules/programs/yazi.nix");

  programs.yazi =
  {
    enable = true;
    initLua = ./init.lua;
  };

  # We can't use xdg-open for opening files with editor,
  # because it would start a new Kitty window
  # Instead, Yazi just uses $EDITOR, which is fine.
  # See the relevant issue for fixing that:
  # https://github.com/llakala/nixos/issues/74


  # Yazi seems to be using mpv by default, but we want it to reuse mimetypes
  # See the source code where it's set:
  # https://github.com/sxyazi/yazi/blob/ce9092e73e5c73f4bb48d7cd0c52e8d9fedaf30f/yazi-config/preset/yazi-default.toml#L55
  programs.yazi.settings.yazi.opener =
  {
    play = lib.singleton
    {
      run = "xdg-open \"$@\"";
      orphan = true;
      desc = "Open";
    };
  };

  programs.yazi.settings.yazi.manager =
  {
    sort_by = "extension";
    sort_dir_first = true;
  };
}
