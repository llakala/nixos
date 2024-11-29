{ pkgs, config, lib, ... }:

let
  kittab = pkgs.writeShellApplication # Get info on the currently focused window, to be parsed via jq
  {
    name = "kittab";
    runtimeInputs = with pkgs;
    [
      kitty
      jq
    ];
    text =
    ''
      all_metadata=$(kitty @ ls)
      current_tab=$( echo "$all_metadata" | jq ".[].tabs[] | select(.is_focused)" )
      current_window=$( echo "$current_tab" | jq ".windows[] | select(.is_focused)" )
      echo "$current_window"
    '';
  };

  kitname = pkgs.writeShellApplication # Get the current filename, to be used for Helix integrations
  {
    name = "kitname";
    runtimeInputs = with pkgs;
    [
      kittab
      kitty
      jq
      ripgrep
    ];
    text =
    ''
      id="$KITTY_WINDOW_ID"
      file_text=$(kitty @ get-text -m "id:$id") # Text on screen for the current tab. Requires listen_on in kitty config to be a unix socket, otherwise result is non-deterministic

      status_line=$(echo "$file_text" | rg -Po '(?:NOR|INS|SEL)\s+[\x{2800}-\x{28FF}]*\s+\S*\s[^│]* \d+:*.*') # Grab everything within helix status bar
      file_name=$(echo "$status_line" | awk '{print $2}') # Will have full path since keybind sets absolute path before running the script
      echo "$file_name"
    '';
  };

  tempStatusLine = builtins.toJSON # Statusline modified to show the absolute path rather than the relative one
  [
    "mode"
    "spinner"
    "file-absolute-path"
    "read-only-indicator"
    "file-modification-indicator"
  ];

in
{
  environment.systemPackages = lib.singleton kitname;

  hm.programs.helix.settings.keys.normal =
  {
    space.p = # Run current python file
    [
      ":set statusline.left ${tempStatusLine}" # Give kitname access to the absolute path of current file
      ":sh python $(kitname)"
      ":config-reload" # Reset statusbar so it shows relative path again
    ];
  };
}
