{ pkgs, hostVars, ... }:


{
  xdg =
  {
    enable = true;
    userDirs.enable = true;
    mime.enable = true;

    mimeApps =
    {
      enable = true;
    };


    portal =
    {
      enable = true;
      extraPortals = with pkgs;
      [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];

      config.common.default = "gnome";
    };

    # Remove stupid things from side of nautilus
    userDirs.music = hostVars.homeDirectory;
    userDirs.pictures = hostVars.homeDirectory;
    userDirs.videos = hostVars.homeDirectory;
    userDirs.documents = hostVars.homeDirectory;
  };
}