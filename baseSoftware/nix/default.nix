{ ... }:

{
  imports =
  [
    ./lando.nix
    ./nh.nix
    ./nix-ld.nix
    ./virtualization.nix

    ./apps.nix
    ./packages.nix
  ];
}