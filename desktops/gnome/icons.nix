{ lib, pkgs, ... }:

{
  environment.systemPackages = lib.singleton pkgs.adwaita-icon-theme;

  hm.gtk =
  {
    enable = true;

    iconTheme =
    {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };
  };
}
