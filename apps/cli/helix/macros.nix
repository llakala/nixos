{ inputs, pkgs, lib, ... }:

let
  sharedBinds =
  {
    # Select next word, with no spaces included. Great for replacing via `q+c`
    q = "@emiw";
    A-q = "@emiW";

    space.p = "@:sh python <C-r>%<ret>"; # Run the current file in Python
  };
in
{
  hm.programs.helix =
  {
    package = inputs.helix-unstable.packages.${pkgs.system}.default; # Compile helix from source, pointing to commit adding macro support

    settings.keys = # Extra binds to live alongside the binds declared in other files
    {
      normal = lib.mkAfter sharedBinds;
      select = lib.mkAfter sharedBinds;
    };
  };
}
