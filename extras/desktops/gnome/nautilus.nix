{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs;
  [
    nautilus
  ];
  hm =
  {
    dconf.settings =
    {
      # Within Nautilus
      "org/gtk/gtk4/settings/file-chooser" =
      {
        show-hidden = true;
      };

      # When downloading files
      "org/gtk/settings/file-chooser" =
      {
        show-hidden = true;
      };
    };

    gtk =
    {
      enable = true;
      gtk3.bookmarks =
      [
        "file:///" # Root
        "file://${config.hostVars.configDirectory}" # nixos config directory
        "file://${config.hostVars.homeDirectory}/VMS"
      ];
    };

    xdg.configFile."gtk-3.0/bookmarks".force = true;
    xdg.configFile."gtk-4.0/settings.ini".force = true;
    xdg.configFile."gtk-3.0/settings.ini".force = true;

    xdg.userDirs =
    {
      enable = true;
      createDirectories = true;

      # Remove music and videos directories from sidebar
      music = null;
      videos = null;
    };
    xdg.configFile."user-dirs.dirs".force = true;
  };
}
