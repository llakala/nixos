{ pkgs, config, ... }:

{

  programs.steam =
  {
    enable = true;

    # Open ports in the firewall for Steam Remote Play
    remotePlay.openFirewall = true;

    # Open ports in the firewall for Source Dedicated Server
    dedicatedServer.openFirewall = true;

    gamescopeSession.enable = true;
    package = pkgs.steam.override
    {
      extraArgs = "-forcedesktopscaling ${toString config.hostVars.scalingFactor}";
    };
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

}
