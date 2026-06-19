{ self, pkgs, ... }:

{
  features.desktop = "plasma"; # If we ever stop using KDE, change this
  services.desktopManager.plasma6.enable = true;

  hm.imports = [ "${self.sources.plasma-manager}/modules" ];
  hm.programs.plasma = {
    enable = true;
    overrideConfig = true; # Reset any imperative settings on login

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";

      # Pretty orange tree :3
      wallpaper = ./wallpaper.png;
    };
  };

  # See https://discuss.kde.org/t/logout-reboot-and-shutdown-using-the-terminal/743
  environment.shellAliases = {
    logout = "qdbus org.kde.Shutdown /Shutdown logout";
    reboot = "qdbus org.kde.Shutdown /Shutdown logoutAndReboot";
    shutdown = "qdbus org.kde.Shutdown /Shutdown logoutAndShutdown";
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    okular
    dolphin
    discover
    kate
    elisa
    konsole

    plasma-browser-integration
    plasma-workspace-wallpapers
  ];

  # If you ever need to figure out the name, set this to an empty string and try
  # to rebuild - it'll fail and tell you the valid options
  services.displayManager.defaultSession = "plasma";

  hm.gtk = {
    gtk2.configLocation = "${self.baseVars.homeDirectory}/.config/.gtkrc-2.0";
  };

  # On by default - I'll save on my closure size
  services.orca.enable = false;
  services.speechd.enable = false;
}
