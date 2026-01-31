{ self, pkgs, ... }:

{
  features.desktop = "plasma"; # If we ever stop using KDE, change this
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    okular
    dolphin
  ];

  # If you ever need to figure out the name, set this to an empty string and try
  # to rebuild - it'll fail and tell you the valid options
  services.displayManager.defaultSession = "plasma";

  hm.imports = [ "${self.sources.plasma-manager}/modules" ];
  hm.programs.plasma = {
    enable = true;
    overrideConfig = true; # Reset any imperative settings on login
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
  };

  hm.gtk = {
    gtk2.configLocation = "${self.baseVars.homeDirectory}/.config/.gtkrc-2.0";
  };

  # Pretty orange tree :3
  hm.programs.plasma.workspace.wallpaper = ./wallpaper.png;

  # On by default - I'll save on my closure size
  services.orca.enable = false;
  services.speechd.enable = false;
}
