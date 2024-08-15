{ pkgs, hostVars, ... }:

{


  virtualisation = # NOT VIRTUALIZATION
  {
    libvirtd.enable = true;
    docker.enable = true;
    spiceUSBRedirection.enable = true; # Make spice able to pass usb devices easily
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