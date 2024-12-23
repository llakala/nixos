{ pkgs, config, lib, ... }:

let
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy"; # Package used for smart-paste. Installed here so we don't rely on a package being installed
in
{
  hm.programs.yazi.keymap.manager.prepend_keymap = # keymap.toml settings, documented here https://yazi-rs.github.io/docs/configuration/keymap
  [
    {
      desc = "Open the selected files";
      on = lib.singleton "i"; # Same as "o" for open, but for my helix muscle memory
      run = "open";
    }

    {
      desc = "Go to the NixOS configuration directory";
      on = ["g" "n"];
      run = "cd ${config.baseVars.configDirectory}";
    }

    {
      desc = "Go to the projects folder for working on external Git repos";
      on = [ "g" "p" ];
      run = "cd ~/Documents/projects";
    }

    {
      desc = "Go to the classes directory for working on homework";
      on = [ "g" "c" ];
      run = "cd ~/Documents/classes";
    }

    {
      desc = "Paste into a directory if we're hovering over it";
      on = lib.singleton "p";
      run = "plugin smart-paste";
    }

    {
      desc = "When copying, copy to the system clipboard as well";
      on = lib.singleton "y";
      run =
      [
        "yank"
        ''
          shell --confirm 'for path in "$@"; do echo "file://$path"; done | ${wl-copy} -t text/uri-list'
        ''
      ];
    }

    { # Swapped `q` and `Q`, since returning to the previous directory is what I want more often
      desc = "Exit normally, returning to wherever you previously were before entering Yazi";
      on = "q";
      run = "quit --no-cwd-file";
    }

    {
      desc = "Exit to wherever we currently are within the filetree";
      on = "Q";
      run = "quit";
    }
  ];

  hm.xdg.configFile."yazi/plugins/smart-paste.yazi/init.lua".text = builtins.readFile ./plugins/smart-paste.lua;

}
