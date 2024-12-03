{ lib, ... }:

{

  hm.programs.zoxide = # run "zoxide" to see manpages, etc
  {
    enable = true;
    options = lib.singleton "--cmd cd"; # Give `cd` `z` functionality, `z` no longer does anything
  };

}