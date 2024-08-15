{ pkgs, hostVars, ... }:

{


  virtualisation = # NOT VIRTUALIZATION
  {
    libvirtd.enable = true;
    docker.enable = true;
    spiceUSBRedirection.enable = true; # Give permission for USB drives to be passed through spice
  };

  users.users.${hostVars.username}.extraGroups = ["libvirtd" "docker" ];

  services.spice-webdavd.enable = true;

  environment.systemPackages = with pkgs;
  [
    quickemu # Easy virtual machines
    qemu-utils # Virtualization

    lsof # List open files
  ];

}