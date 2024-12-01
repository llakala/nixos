{ pkgs, config, ... }:

{


  virtualisation = # WITH AN S, NOT A Z
  {
    libvirtd.enable = false; # Until https://github.com/NixOS/nixpkgs/issues/338314 is fixed
    spiceUSBRedirection.enable = true; # Give permission for USB drives to be passed through spice
  };

  virtualisation.docker =
  {
    enable = true;
    enableOnBoot = false;
  };

  users.users.${config.hostVars.username}.extraGroups = [ "libvirtd ""docker" ];

  services.spice-webdavd.enable = true;

  environment.systemPackages = with pkgs;
  [
    quickemu # Easy virtual machines
    qemu-utils # Virtualization
    # quickgui # TODO: BRING BACK WHEN https://github.com/NixOS/nixpkgs/issues/341893 IS FIXED
  ];

}