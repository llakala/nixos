{ config, ... }:

{
  networking =
  {
    hostName = config.hostVars.hostName;

    firewall.enable = true;
    resolvconf.dnsExtensionMechanism = false; # Wifi doesn't work unless I do this
  };

  networking.networkmanager.enable = true;
  users.users.${config.hostVars.username}.extraGroups = [ "networkmanager"];

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;  # Enable ip forwarding

  hardware.bluetooth =
  {
    enable = true;
    powerOnBoot = false; # Why not save some battery
  };

  services.openssh.enable = true;
}