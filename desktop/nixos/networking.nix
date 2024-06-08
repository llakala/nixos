{
  vars,
  ...
}:

{
  networking =
  {
    hostName = vars.hostName;
    networkmanager.enable = true;

    firewall.enable = true;
    resolvconf.dnsExtensionMechanism = false;
  };
}