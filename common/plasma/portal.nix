{ pkgs, config, ... }:

{
  xdg.portal = assert config.features.desktop == "plasma"; {
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  };
}
