{
  # Screenshot button for rectangular shortcut
  hm.programs.plasma.shortcuts."services/org.kde.spectacle.desktop" = {
    RectangularRegionScreenShot = "Print";
    _launch = "Meta+Shift+S";
  };

  hm.programs.plasma.configFile.spectaclerc = {
    # Copy on accept
    General.clipboardGroup = "PostScreenshotCopyImage";
  };

  hm.programs.plasma.shortcuts.kwin = {
    "Window Maximize" = "Meta+Space";
  };
}
