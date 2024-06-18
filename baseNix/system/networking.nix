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

  services.openssh.enable = true;
}