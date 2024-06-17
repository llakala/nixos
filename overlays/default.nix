{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays =
  [

    (final: prev:
    {
      firefox-org = prev.firefox.overrideAttrs
      {
        buildCommand = oldAttrs.buildCommand +
        ''
        wrapProgram $out/bin/firefox \
          --set MOZ_ENABLE_WAYLAND 0
        '';
      };
    })



  ];
}