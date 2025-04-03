{ pkgs, lib, ... }:

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
      desc = "Go to the top of the git repo";
      on = [ "g" "r" ];
      run = "shell -- ya emit cd \"$(git rev-parse --show-toplevel)\"";
    }

    {
      desc = "Move cursor to the bottom";
      on = [ "g" "G" ];
      run = "arrow bot";
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
