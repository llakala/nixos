{
  hm.programs.firefox.policies.Preferences =
  {
    "browser.urlbar.suggest.calculator" = true;
    "browser.urlbar.unitConversion.enabled" = true;
    "browser.urlbar.trimHttps" = true;

    "browser.urlbar.suggest.searches" = true; # Need this for basic search suggestions
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.shortcuts.history" = false;
    "browser.urlbar.shortcuts.tabs" = false;

    "browser.tabs.tabMinWidth" = 75; # Make tabs able to be smaller to prevent scrolling

    "browser.urlbar.placeholderName" = "DuckDuckGo";
    "browser.urlbar.placeholderName.private" = "DuckDuckGo";

    "browser.aboutConfig.showWarning" = false; # No warning when going to config
    "browser.warnOnQuitShortcut" = false;

    "browser.tabs.loadInBackground" = true; # Load tabs automatically
    "browser.tabs.closeTabByDblclick" = true;

    "media.ffmpeg.vaapi.enabled" = true; # Enable hardware acceleration
    "layers.acceleration.force-enabled" = true;
    "gfx.webrender.all" = true;

    "browser.in-content.dark-mode" = true; # Use dark mode
    "ui.systemUsesDarkTheme" = true;

    "extensions.autoDisableScopes" = 0; # Automatically enable extensions
    "extensions.update.enabled" = false;

    "widget.use-xdg-desktop-portal.file-picker" = 1; # Use new gtk file picker instead of legacy one
  };

  hm.programs.firefox.policies.Preferences."browser.uiCustomization.state" = builtins.toJSON
  {
    placements =
    {
      widget-overflow-fixed-list = [];
      toolbar-menubar = [ "menubar-items" ];
      PersonalToolbar = [ "personal-bookmarks" ];
      nav-bar =
      [
        "back-button"
        "forward-button"
        "urlbar-container"
        "downloads-button"
        "unified-extensions-button"
      ];
      TabsToolbar =
      [
        "firefox-view-button"
        "tabbrowser-tabs"
        "new-tab-button"
      ];
      unified-extensions-area =
      [
        "sponsorblocker_ajay_app-browser-action"
        "ublock0_raymondhill_net-browser-action"
        "gdpr_cavi_au_dk-browser-action"
        "redirector_einaregilsson_com-browser-action"
        "_5183707f-8a46-4092-8c1f-e4515bcebbad_-browser-action"
        "_b0a674f9-f848-9cfd-0feb-583d211308b0_-browser-action"
        "jid0-3guet1r69sqnsrca5p8kx9ezc3u_jetpack-browser-action"
        "_74145f27-f039-47ce-a470-a662b129930a_-browser-action"
        "_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action"
        "_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action"
        "_cb31ec5d-c49a-4e5a-b240-16c767444f62_-browser-action"
      ];
    };
    currentVersion = 20;
    newElementCount = 3;
  };
}
