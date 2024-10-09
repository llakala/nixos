{ lib, pkgs, ... }:
# Makes Helix, Yazi, and Kitty all work together for a filetree. Thanks to Ghashy for the guide, seen here:
# https://www.reddit.com/r/HelixEditor/comments/1bgsauh/instruction_how_to_setup_file_tree_in_helix_using/
# Also a lot of thanks to Vesdef for having an excellent reference configuration, seen here:
# https://github.com/vesdev/nixconf/blob/273824d7a697969c83f044ea46a61992ac1bfaa4/mod/hm/dotfiles/yazi.nix#L29
{
  hm.programs.yazi =
  {
    settings =
    {
      manager.ratio = [ 0 8 0 ];
    };

    keymap.manager.prepend_keymap = lib.singleton
    {
      on = lib.singleton "u"; # Keybind for yazi to open a file within helix
      run = "plugin --sync smart-enter";
      desc = "Enter the child directory, or open the file";
    };

    plugins =
    {
      "smart-enter" = ./smart-enter;
    };

  };





  environment.systemPackages = lib.singleton
  (
    pkgs.writeShellScriptBin "open_file_tree.bash"
    ''
      #!/usr/bin/env bash
      desired_width=25

      # Open window on the left
      YAZI_CONFIG_HOME=~/.config/yazi yazi

      # Use jq to filter the JSON output based on the specific window ID
      current_width=$(kitty @ ls | jq --arg window_id "$KITTY_WINDOW_ID" '.[].tabs[].windows[] | select(.id == ($window_id | tonumber)) | .columns')

      # Calculate the increment value
      increment=$((desired_width - current_width))

      # Resize the window with the calculated increment value
      kitten @ resize-window --increment $increment --axis horizontal
    ''
  );

  hm.programs.kitty =
  {
    settings =
    {
      allow_remote_control = true;
      enabled_layouts = "splits:split_axis=horizontal";
    };
    keybindings = # Keybind for bringing up file manager
    {
      "ctrl+b" = "launch --location before --cwd current --title tree open_file_tree.bash";
    };
  };


}
