{ lib, ... }:

let
  # All binds used here rely on macros, introduced since Helix 25.01
  sharedBinds =
  {
    # Select next word, with no spaces included. Great for replacing via `q+c`
    q = "@emiw";
    A-q = "@emiW";

    space.p = "@:sh python <C-r>%<ret>"; # Run the current file in Python
  };
in
{
  # Extra binds to live alongside the binds declared in other files
  hm.programs.helix.settings.keys =
  {
    normal = lib.mkAfter sharedBinds;
    select = lib.mkAfter sharedBinds;
  };


  # Binary cache for Helix unstable
  nix.settings =
  {
    substituters = lib.singleton "https://helix.cachix.org";
    trusted-public-keys = lib.singleton "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs=";
  };
}
