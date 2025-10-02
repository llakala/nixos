{ pkgs, ... }:

{
  # Using this over the programs.plasma solution, as that one seems to run on
  # every rebuild. From: https://discourse.nixos.org/t/set-wallpaper-on-kde-plasma/59796
  systemd.user.services.set-wallpaper = {
    enable = true;
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    description = "Set wallpaper";

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.plasma-workspace}/plasma-apply-wallpaperimage ${./wallpaper.png}";
    };
  };
}
