{ ... }:

{
  imports =
  [
    ./bootloader.nix
    ./networking.nix
    ./nixos.nix
    ./user.nix
  ];
}