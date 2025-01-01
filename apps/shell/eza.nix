{ lib, ... }:

{

  hm.programs.eza = # Replaces aliases already in its config
  {
    enable = true;
    icons = "auto";

    extraOptions = lib.cli.toGNUCommandLine
    { optionValueSeparator = "="; }
    {
      group-directories-first = true;
      hyperlink = true; # Ctrl+Click a file to go directly to it
      sort = "extension";

      smart-group = true; # Show group if it's not the default
      header = true;
      total-size = true; # Show the size of a folder's contents

      no-permissions = true;
      no-user = true;
    };
  };

}