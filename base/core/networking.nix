{
  hostVars,
  ...
}:

{
  networking =
  {
    hostName = hostVars.hostName;
    networkmanager.enable = true;

    firewall.enable = true;
    resolvconf.dnsExtensionMechanism = false;
  };
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;  # Enable ip forwarding

  hardware.bluetooth =
  {
    enable = true;
    powerOnBoot = false; # Why not save some battery
  };

  services.openssh.enable = true;
}