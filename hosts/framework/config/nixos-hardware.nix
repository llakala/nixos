{ inputs, ... }:

{
  imports =
  [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  # Bios updates
  services.fwupd =
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
