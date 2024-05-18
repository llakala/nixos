{ }:

{
  imports =
  [ # Include the results of the hardware scan.
    ./boilerplate.nix
    ./bootloader.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./nvidia.nix
    ./sound.nix
  ];
}
