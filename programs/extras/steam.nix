{ pkgs, hostVars, ... }:

{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = "-forcedesktopscaling ${toString hostVars.scalingFactor}";
    };
  };

  programs.gamemode.enable = true;
}
