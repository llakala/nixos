{ lib, pkgs, ... }:


{
  hm.programs.helix =
  {
    enable = true;
    defaultEditor = false; # We do this manually via the EDITOR variable
  };

  hm.programs.helix.settings =
  {
    theme = "onedarker";
    editor.indent-guides.render = true; # Show where indentations are with |
  };

  hm.programs.helix.settings.keys =
  {
    normal = # We WILL learn hjkl
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
    };
    insert = # And we WILL only use normal mode for moving around
    {
      up = "no_op";
      down = "no_op";
      left = "no_op";
      right = "no_op";
    };
  };


  hm.programs.helix.languages.language =
  [
    {
      name = "nix";
      auto-format = false;
      language-servers = lib.singleton "nil";
    }
  ];

  hm.programs.helix.languages.language-server = # Define language server executables here so helix can access them
  {
    nil.command = lib.getExe pkgs.nil;
  };
}