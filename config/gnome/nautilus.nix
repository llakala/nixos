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
    "org/gtk/gtk4/settings/file-chooser" = # Within Nautilus
      {
        show-hidden = true;
      };

      "org/gtk/settings/file-chooser" = # When downloading files
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
        "file://${config.baseVars.configDirectory}" # nixos config directory
        "file://${config.hostVars.homeDirectory}/VMS"
      ];
    };

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
