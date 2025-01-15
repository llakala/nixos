{ lib, myLib, ... }:

let
  options = lib.cli.toGNUCommandLineShell # True values correspond to setting a flag
  {}
  {
    multi = true;
    exact = true;
    ansi = true;
    cycle = true;
    reverse = true;

    highlight-line = true;
    inline-info = true;
    border = true;
    no-separator = true;

    bind = myLib.mkFzfBinds
    {
      j = "down";
      k = "up";

      i = "change-header(INSERT MODE)+enable-search+unbind(i,j,k)";
      start = "change-header(NORMAL MODE)+disable-search";
      esc = "change-header(NORMAL MODE)+disable-search+rebind(i,j,k)";
    };
  };
in
{
  hm.programs.fzf =
  {
    enable = true;

    # Needs a reboot to apply
    # True values correspond to setting a flag
    defaultOptions = lib.singleton options;
  };
}
