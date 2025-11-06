{ pkgs, self, ... }:

let
  kittab = self.packages.kittab;

  # Create a new desktop entry that we'll use for opening Kitty
  # Within the Kittab script, we make Kitty open with class/name Kittab, so it doesn't
  # open `kitty.desktop`, but instead stays within `kittab.desktop`
  # Stored to /run/current-system/sw/share/applications
  kittabEntry = pkgs.makeDesktopItem {
    type = "Application";
    name = "kittab"; # ${name}.desktop
    desktopName = "Kittab";
    genericName = "Terminal emulator";
    exec = "kittab";
    icon = "kitty";
    categories = [ "System" "TerminalEmulator" ]; # Apparently these are important, removing them broke things
  };

  kittyPackage = pkgs.symlinkJoin {
    name = "kittab";
    paths = [
      kittab
      kittabEntry
      self.wrappers.kitty.drv
    ];
  };

in {
  features.terminal = "kitty"; # Change if I ever stop using Kitty
  features.usingKittab = true; # For assertions, so we can rely on kittab's existence

  environment.systemPackages = [ kittyPackage ];

  # We can't use the `shell_integration` output of our wrapper, since wrappers
  # don't preserve attributes like this
  hm.programs.fish.interactiveShellInit = ''
    source "${pkgs.kitty.shell_integration}/fish/vendor_conf.d/kitty-shell-integration.fish"
    set --prepend fish_complete_path "${pkgs.kitty.shell_integration}/fish/vendor_completions.d"
  '';
}
