{ ... }:

{
  imports =
  [
    ./bootloader.nix
    ./networking.nix
    ./nixos.nix
    ./sound.nix
    ./user.nix
    ./virtualization.nix
  ];
}