{ lib, ... }:
{
  hm.programs.fzf =
  {
    enable = true;

    # Needs a reboot to apply
    defaultOptions = lib.singleton
    (
      lib.cli.toGNUCommandLineShell {} # True values correspond to setting a flag
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
      }
    );
  };
}
