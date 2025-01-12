{ lib, myLib, ... }:

{
  hm.programs.fzf =
  {
    enable = true;

    # Needs a reboot to apply
    defaultOptions = lib.cli.toGNUCommandLine # True values correspond to setting a flag
    { optionValueSeparator = "="; }
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
        start = "unbind(i,j,k)";
        esc = "disable-search+rebind(i,j,k)";
        i = "enable-search+unbind(i,j,k)";
      };
    };
  };
}
