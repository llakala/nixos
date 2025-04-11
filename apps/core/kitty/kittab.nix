{ self, pkgs, pkgs-unstable, lib, ... }:

let
  kittab = self.legacyPackages.${pkgs.system}.kittab;

  # Create a new desktop entry that we'll use for opening Kitty
  # Within the Kittab script, we make Kitty open with class/name Kittab, so it doesn't
  # open `kitty.desktop`, but instead stays within `kittab.desktop`
  # Stored to /run/current-system/sw/share/applications
  kittabEntry = pkgs.makeDesktopItem
  {
    type = "Application";

    # ${name}.desktop
    name = "kittab";
    desktopName = "Kittab";

    genericName = "Terminal emulator";

    exec = "kittab";

    icon = "kitty";

    # Apparently these are important, removing them broke things
    categories = [ "System" "TerminalEmulator" ];
  };

in
{
  # For assertions, so we can rely on kittab's existence
  features.usingKittab = true;

  hm.programs.kitty.package = pkgs.symlinkJoin
  {
    name = "kittab";
    paths =
    [
      kittab
      kittabEntry
      pkgs-unstable.kitty
    ];
  };
}
