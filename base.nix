{ nixpkgs, disko, pkgs, ... }:


{


  nix.modules =
  [
    ./baseNix/core
    ./baseNix/features
    ./baseNix/os
    ./baseNix/software

    ./packages/nixPackages.nix

    ./overlays

    {nixpkgs.pkgs = pkgs; } # Makes sure the pkgs declared in flake.nix is properly passed
    disko.nixosModules.disko
  ];

  home.modules =
  [
    ./baseHome/core
    ./baseHome/features
    ./baseHome/os
    ./baseHome/software

    ./packages/homePackages.nix

    ./overlays
  ];
}