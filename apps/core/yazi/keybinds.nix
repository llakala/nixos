{ pkgs, config, lib, ... }:

let
  # Package used for smart-paste. Installed here so we don't rely
  # on a system package being installed
  wl-copy = lib.getExe' pkgs.wl-clipboard "wl-copy";

in
{
  # keymap.toml settings, documented here https://yazi-rs.github.io/docs/configuration/keymap
  hm.programs.yazi.keymap.manager.prepend_keymap =
  [
    {
      desc = "Open the selected files";
      on = "i"; # Same as "o" for open, but for my helix muscle memory
      run = "open";
    }

    {
      desc = "Move cursor to the bottom";
      on = [ "g" "G" ];
      run = "arrow 99999999";
    }

    {
      desc = "Go to the NixOS configuration directory";
      on = ["g" "n"];
      run = "cd ${config.baseVars.configDirectory}";
    }

    {
      desc = "Go to the projects folder for working on my personal repos";
      on = [ "g" "p" ];
      run = "cd ~/Documents/projects";
    }

    {
      desc = "Go to the classes directory for working on homework";
      on = [ "g" "c" ];
      run = "cd ~/Documents/classes";
    }

    {
      desc = "Go to the repos directory for working on external Git repos";
      on = [ "g" "r" ];
      run = "cd ~/Documents/repos";
    }


    {
      desc = "When copying, copy to the system clipboard as well";
      on = "y";
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
}
