{ ... }:

{
  imports =
  [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./nixos.nix
    ./nvidia.nix
    ./sound.nix
    ./user.nix
  ];
}
