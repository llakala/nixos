{ disko, nixpkgs, pkgs, ... }:


{
  nix =
  {
    modules =
    [
      ./baseNix/core
      ./baseNix/features
      ./baseNix/os
      ./baseNix/software

      ./packages/nixPackages.nix

      ./overlays

      {nixpkgs.pkgs = pkgs; }
      disko.nixosModules.disko
    ];
  };

  home =
  {
    modules =
    [
      ./baseHome/core
      ./baseHome/features
      ./baseHome/os
      ./baseHome/software

      ./packages/homePackages.nix

      ./overlays
    ];
  };
}