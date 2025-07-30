{ lib, pkgs, config, ... }:

{
  environment.systemPackages = lib.singleton pkgs.adwaita-icon-theme;

  # This affects global state outside of Gnome, so only modify it if we're
  # really using gnome and not just on it temporarily
  hm.gtk = lib.mkIf (config.features.desktop == "gnome")
  {
    enable = true;

    iconTheme =
    {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
