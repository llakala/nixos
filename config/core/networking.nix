{ config, lib, ... }:

{
  networking = {
    hostName = config.hostVars.hostName;

    networkmanager.enable = true;
    wireless.enable = lib.mkForce false;

    firewall.enable = true;
    resolvconf.dnsExtensionMechanism = false; # Wifi doesn't work unless I do this
  };

  users.users.${config.hostVars.username}.extraGroups = [ "networkmanager"];

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;  # Enable ip forwarding

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false; # Why not save some battery
  };
}
