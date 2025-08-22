{ lib, ... }:

{
  hm.programs.ripgrep = {
    enable = true;
    arguments = lib.cli.toGNUCommandLine {}
    {
      smart-case = true;
      pretty = true;
    };
  };
}
