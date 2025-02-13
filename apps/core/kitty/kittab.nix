{ self, pkgs, lib, ... }:

let
  kittab = self.legacyPackages.${pkgs.system}.kittab;
in
{
  features.usingKittab = true; # For assertions, so we can rely on kittab's existence

  # Create a new desktop entry that we'll use for opening Kitty
  # Within the Kittab script, we make Kitty open with class/name Kittab, so it doesn't
  # open `kitty.desktop`, but instead stays within `kittab.desktop`
  # Also, for the curious, home-manager stores this at:
  # /etc/profiles/per-user/MYUSERNAME/share/applications
  hm.xdg.desktopEntries.kittab =
  {
    name = "Kittab";
    genericName = "Text Editor";
    exec = "${lib.getExe kittab}";
    icon = "kitty";
    terminal = false;
    categories = [ "Development" "IDE" ];
    mimeType = [ "text/plain" ];
  };
}
