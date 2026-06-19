{ pkgs, self, ... }:

{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraArgs = "-forcedesktopscaling ${toString self.hostVars.scalingFactor}";
    };
  };

  programs.gamemode.enable = true;
}
