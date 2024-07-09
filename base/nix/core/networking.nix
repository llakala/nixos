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

  hardware.bluetooth =
  {
    enable = true;
    powerOnBoot = true;
  };

  services.openssh.enable = true;
}