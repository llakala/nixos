{ vars, hostVars, pkgs, ... }:

{
  home.packages = with pkgs;
  [
    nautilus
  ];
  
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
      "file://${vars.configDirectory}" # nixos config directory
      "file://${hostVars.homeDirectory}/VMS"
    ];
  };

  xdg.userDirs = # Changes only apply on reboot
  {
    enable = true;
    createDirectories = true;

    music = null;
    videos = null;
  };
}