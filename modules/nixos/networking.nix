{ ... }:

{
  networking =
    {
      hostName = "mypc";
      networkmanager.enable = true;

      firewall.enable = true;
      resolvconf.dnsExtensionMechanism = false;
    };
}