{
  # Matching the Gnome defaults I'm used to
  hm.programs.plasma.input.keyboard =
  {
    repeatDelay = 500;
    repeatRate = 30;
  };

  # Screenshot button for rectangular shortcut
  hm.programs.plasma.shortcuts."services/org.kde.spectacle.desktop" =
  {
    RectangularRegionScreenShot = "Print";
    _launch = "Meta+Shift+S";
  };

  # Super+Up to maximize window
  hm.programs.plasma.shortcuts.kwin =
  {
    "Window Maximize" = "Meta+Up";
  };


}
