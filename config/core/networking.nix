{ config, lib, ... }:

{
  networking =
  {
    hostName = config.hostVars.hostName;

    networkmanager.enable = true;
    wireless.enable = lib.mkForce false;

    firewall.enable = true;

    # Wifi doesn't work unless I do this
    resolvconf.dnsExtensionMechanism = false;
  };

  users.users.${config.hostVars.username}.extraGroups = [ "networkmanager"];

  # Enable ip forwarding
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1; 

  hardware.bluetooth =
  {
    enable = true;

    # Why not save some battery
    powerOnBoot = false;
  };

  services.openssh.enable = true;
}
