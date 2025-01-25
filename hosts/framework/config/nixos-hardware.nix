{ inputs, lib, ... }:

{
  imports =
  [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  services.fwupd = # Bios updates
  {
    enable = true;
    extraRemotes = lib.singleton "lvfs-testing";
  };
}