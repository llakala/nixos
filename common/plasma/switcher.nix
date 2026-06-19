{
  hm.programs.plasma.shortcuts.kwin = {
    "Walk Through Windows" = "Alt+Esc";
    "Walk Through Windows (Reverse)" = "Alt+Shift+Esc";

    "Walk Through Windows Alternative" = "Alt+Tab";
    "Walk Through Windows Alternative (Reverse)" = "Alt+Shift+Tab";

    "Window Maximize" = "Meta+F";
    "Window Minimize" = "Meta+M";
    MinimizeAll = "Meta+Shift+M";
    "Window Close" = "Meta+Q";

    "Switch Window Left" = "Meta+H";
    "Switch Window Down" = "Meta+J";
    "Switch Window Up" = "Meta+K";
    "Switch Window Right" = "Meta+L";

    "Window Quick Tile Left" = "Meta+Shift+H";
    "Window Quick Tile Bottom" = "Meta+Shift+J";
    "Window Quick Tile Top" = "Meta+Shift+K";
    "Window Quick Tile Right" = "Meta+Shift+L";
  };

  hm.programs.plasma.configFile.kdeglobals = {
    Shortcuts.Quit = "";
  };

  hm.programs.plasma.configFile.kwinrc = {
    # Disable "hot corners"
    ElectricBorders.TopLeft = "";
    Effect-overview.BorderActivate = 9;

    TabBox = {
      LayoutName = "sidebar";
      ShowTabBox = false;
    };

    TabBoxAlternative = {
      LayoutName = "big_icons";
      ShowTabBox = true;
    };

    Plugins.minimizeallEnabled = true;
  };
}
