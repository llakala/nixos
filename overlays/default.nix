{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays =
  [

    (final: prev:
    {
      firefox-org = prev.firefox.overrideAttrs
      (oldAttrs:
      {
        buildCommand = (oldAttrs.buildCommand or "") +
        ''
        wrapProgram $out/bin/firefox \
        --set MOZ_ENABLE_WAYLAND 0 # Disable wayland
        '';
      });
    })



  ];
}