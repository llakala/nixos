{ ... }:

{
  imports =
  [
    ./bootloader.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./nvidia.nix
    ./sound.nix
    ./user.nix
  ];
}
