{ self, pkgs, pkgs-unstable, ... }:

let
  kittab = self.legacyPackages.${pkgs.system}.kittab;

  # Create a new desktop entry that we'll use for opening Kitty
  # Within the Kittab script, we make Kitty open with class/name Kittab, so it doesn't
  # open `kitty.desktop`, but instead stays within `kittab.desktop`
  # Stored to /run/current-system/sw/share/applications
  kittabEntry = pkgs.makeDesktopItem
  {
    type = "Application";

    name = "kittab"; # ${name}.desktop
    desktopName = "Kittab";

    genericName = "Terminal emulator";

    exec = "kittab";

    # Reuse the icon from Kitty. Fun fact - if you just set this to "kitty", you
    # get a nix store in your $PATH. So, we do this instead.
    icon = "${pkgs-unstable.kitty}/share/icons/hicolor/256x256/apps/kitty.png";
    categories = [ "System" "TerminalEmulator" ]; # Apparently these are important, removing them broke things
  };

in
{
  features.usingKittab = true; # For assertions, so we can rely on kittab's existence

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
