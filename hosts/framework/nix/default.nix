{ ... }:

{
  imports =
  [
    #./disko.nix
    ./hardware.nix
    ./hardware-configuration.nix
    ./nixos-generate.nix
  ];
}
