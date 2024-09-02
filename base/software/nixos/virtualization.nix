{ pkgs, hostVars, ... }:

{


  virtualisation = # WITH AN S, NOT A Z
  {
    libvirtd.enable = false; # Until https://github.com/NixOS/nixpkgs/issues/338314 is fixed
    docker.enable = true;
    spiceUSBRedirection.enable = true; # Give permission for USB drives to be passed through spice
  };

  users.users.${hostVars.username}.extraGroups = [ "libvirtd ""docker" ];

  services.spice-webdavd.enable = true;

  environment.systemPackages = with pkgs;
  [
    quickemu # Easy virtual machines
    qemu-utils # Virtualization
    quickgui
  ];

}