{ lib, ... }:

let
  sharedBinds = # All binds used here rely on macros, introduced since the latest Helix stable release
  {
    # Select next word, with no spaces included. Great for replacing via `q+c`
    q = "@emiw";
    A-q = "@emiW";

    space.p = "@:sh python <C-r>%<ret>"; # Run the current file in Python
  };
in
{
  hm.programs.helix.settings.keys = # Extra binds to live alongside the binds declared in other files
  {
    normal = lib.mkAfter sharedBinds;
    select = lib.mkAfter sharedBinds;
  };


  nix.settings = # Binary cache for Helix unstable. Use `extra` to append to previously defined ones
  {
    substituters = lib.mkBefore
    (
      lib.singleton "https://helix.cachix.org"
    );
    trusted-public-keys = lib.singleton "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs=";
  };
}
