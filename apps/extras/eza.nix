{ lib, ... }:

{

  # Replaces aliases already in its config
  hm.programs.eza =
  {
    enable = true;

    icons = "auto";
    git = true;

    extraOptions = lib.cli.toGNUCommandLine

    # Eza doeasn't allow `--opt arg syntax`
    { optionValueSeparator = "="; }
    {
      group-directories-first = true;

      # Shift+Click a file to go directly to it
      hyperlink = true;
      sort = "extension";

      # Show group if it's not the default one
      smart-group = true;
      header = true;

      # Show the size of a folder's contents
      total-size = true;
      time-style = "+%b %d, %Y";

      no-permissions = true;
      no-user = true;

      oneline = true;
    };
  };

  environment.variables.EZA_COLORS = "da=32";
}
