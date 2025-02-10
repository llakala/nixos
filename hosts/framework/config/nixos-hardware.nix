{ inputs, ... }:

{
  imports =
  [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  services.fwupd = # Bios updates
  {
    enable = true;
  };

  # See https://github.com/NixOS/nixos-hardware/blob/dfad538/framework/13-inch/common/audio.nix
  hardware.framework.laptop13.audioEnhancement =
  {
    enable = true;
    hideRawDevice = false;
  };

}
