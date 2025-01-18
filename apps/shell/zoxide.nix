{ lib, ... }:

{

  # run "zoxide" to see manpages, etc
  hm.programs.zoxide =
  {
    enable = true;
    options = lib.singleton "--cmd cd"; # Give `cd` `z` functionality, `z` no longer does anything
  };

}