{ pkgs }:

pkgs.makeDesktopItem {
  type = "Application";
  name = "kittab"; # ${name}.desktop
  desktopName = "Kittab";
  genericName = "Terminal emulator";
  exec = "kittab";
  icon = "kitty";

  # Apparently these are important, removing them broke things
  categories = [ "System" "TerminalEmulator" ];
}
