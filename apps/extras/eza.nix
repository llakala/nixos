{ lib, ... }:

{
  # Replaces aliases already in its config
  hm.programs.eza = {
    enable = true;

    icons = "auto";
    git = true;

    extraOptions = lib.cli.toGNUCommandLine
    { optionValueSeparator = "="; } # Eza doeasn't allow `--opt arg syntax`
    {
      group-directories-first = true;
      hyperlink = true; # Shift+Click a file to go directly to it
      sort = "extension";

      smart-group = true; # Show group if it's not the default one
      header = true;
      total-size = true; # Show the size of a folder's contents
      time-style = "+%b %d, %Y";

      no-permissions = true;
      no-user = true;

      oneline = true;
    };
  };

  environment.variables.EZA_COLORS = "da=32";
}
