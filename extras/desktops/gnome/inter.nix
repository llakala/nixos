{ lib, pkgs, config, ... }:

{
  # This affects global state outside of Gnome, so only modify it if we're
  # really using gnome and not just on it temporarily
  fonts = lib.mkIf (config.features.desktop == "gnome")
  {
    packages = lib.singleton pkgs.inter;

    fontconfig.defaultFonts =
    {
      serif = lib.singleton "Inter";
      sansSerif = lib.singleton "Inter";
    };
  };
}
