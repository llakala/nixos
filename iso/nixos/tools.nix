{ pkgs, hostVars, ... }:

{

  networking.resolvconf.dnsExtensionMechanism = false;

  environment.systemPackages = with pkgs;
  [
    git
  ];

  networking.hostName = hostVars.hostName;
}