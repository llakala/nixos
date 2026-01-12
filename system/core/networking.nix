{ baseVars, hostVars, ... }:

{
  networking = {
    hostName = hostVars.hostname;

    networkmanager.enable = true;

    firewall.enable = true;
    resolvconf.dnsExtensionMechanism = false; # Wifi doesn't work unless I do this
  };

  users.users.${baseVars.username}.extraGroups = [ "networkmanager"];

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;  # Enable ip forwarding

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false; # Why not save some battery
  };
}
