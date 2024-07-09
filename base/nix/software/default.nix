{ ... }:

{
  imports =
  [
    ./lando.nix
    ./nh.nix
    ./nix-ld.nix
    ./virtualization.nix

    ./nixApps.nix
    ./nixPackages.nix
  ];
}