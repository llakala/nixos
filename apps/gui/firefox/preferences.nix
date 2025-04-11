{
  hm.programs.firefox.policies.Preferences =
  {
    "browser.urlbar.suggest.calculator" = true;
    "browser.urlbar.unitConversion.enabled" = true;
    "browser.urlbar.trimHttps" = true;

    # Need this for basic search suggestions
    "browser.urlbar.suggest.searches" = true;
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.shortcuts.history" = false;
    "browser.urlbar.shortcuts.tabs" = false;

    # Make tabs able to be smaller to prevent scrolling
    "browser.tabs.tabMinWidth" = 75;

    "browser.urlbar.placeholderName" = "DuckDuckGo";
    "browser.urlbar.placeholderName.private" = "DuckDuckGo";

    # No warning when going to config
    "browser.aboutConfig.showWarning" = false;
    "browser.warnOnQuitShortcut" = false;

    # Load tabs automatically
    "browser.tabs.loadInBackground" = true;
    "browser.tabs.closeTabByDblclick" = true;

    # Enable hardware acceleration
    "media.ffmpeg.vaapi.enabled" = true;
    "layers.acceleration.force-enabled" = true;
    "gfx.webrender.all" = true;

    # Use dark mode
    "browser.in-content.dark-mode" = true;
    "ui.systemUsesDarkTheme" = true;

    # Automatically enable extensions
    "extensions.autoDisableScopes" = 0;
    "extensions.update.enabled" = false;

    # Use new gtk file picker instead of legacy one
    "widget.use-xdg-desktop-portal.file-picker" = 1;

    # Too glitchy right now
    # "browser.tabs.groups.enabled" = true;
    "browser.tabs.groups.dragOverThresholdPercent" = 10;
  };
}
