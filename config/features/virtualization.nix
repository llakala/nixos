{ pkgs, config, ... }:

{


  # WITH AN S, NOT A Z
  virtualisation =
  {
    # Until https://github.com/NixOS/nixpkgs/issues/338314 is fixed
    libvirtd.enable = false;

    # Give permission for USB drives to be passed through spice
    spiceUSBRedirection.enable = true;
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

    # Easy virtual machines
    quickemu

    # Virtualization
    qemu-utils
    quickgui
  ];

}
