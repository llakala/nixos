{ ... }:

{
  imports =
  [
    ./bootloader.nix
    ./networking.nix
    ./nixos.nix
    ./sound.nix
    #./sops.nix
    ./user.nix
    ./virtualization.nix
  ];
}