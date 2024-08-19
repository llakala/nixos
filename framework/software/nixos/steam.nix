{ pkgs, hostVars, ... }:

{

  programs.steam =
  {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server

    gamescopeSession.enable = true;
  };

  programs.gamescope.enable = true;
    extraPackages = with pkgs;
    [
      gamemode
    ];
  };

}