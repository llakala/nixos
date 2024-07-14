{ ... }:

{
  imports =
  [
    ./bootloader.nix
    ./gdm.nix
    ./networking.nix
    ./nixos.nix
    ./sound.nix
    ./user.nix
  ];
}