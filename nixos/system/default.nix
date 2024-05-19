{ ... }:

{
  imports =
  [
    ./boilerplate.nix
    ./bootloader.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./nvidia.nix
    ./sound.nix
  ];
}
