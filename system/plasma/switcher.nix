{
  hm.programs.plasma.shortcuts.kwin = {
    "Walk Through Windows" = "Alt+Esc";
    "Walk Through Windows (Reverse)" = "Alt+Shift+Esc";

    "Walk Through Windows Alternative" = "Alt+Tab";
    "Walk Through Windows Alternative (Reverse)" = "Alt+Shift+Tab";

    "Window Maximize" = "Meta+Space";

    "Window Quick Tile Top" = [ "Meta+Up" "Meta+K" ];
    "Window Quick Tile Bottom" = [ "Meta+Down" "Meta+J" ];
    "Window Quick Tile Left" = [ "Meta+Left" "Meta+H" ];
    "Window Quick Tile Right" = [ "Meta+Right" "Meta+L" ];
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
  };
}
