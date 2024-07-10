{ pkgs, hostVars, inputs, ...}:

let
  package = pkgs.firefox.overrideAttrs
  (oldAttrs:
  {
    buildCommand = oldAttrs.buildCommand +
    ''
    wrapProgram $out/bin/firefox \
      --set MOZ_ENABLE_WAYLAND 0 \
      --set MOZ_USE_XINPUT2 1
    '';
  });

  policies =
  {
    DontCheckDefaultBrowser = true;
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;

    DisplayBookmarksToolbar = "never";
    DisplayMenuBar = "never"; # Disable the weird file menu that comes up when pressing alt
    OverrideFirstRunPage = "";

    HardwareAcceleration = true;
    TranslateEnabled = true;

    Homepage =
    {
      "StartPage" = "previous-session";
    };
  };

  policies.Handlers = # Sadly doesn't seem to be working, wait for home-manager to implement
  {
    "schemes" =
    {
      "vscode" =
      {
        "action" = "useHelperApp";
        "ask" = false;
      };
      "slack" =
      {
        "action" = "useHelperApp";
        "ask" = false;
      };
    };
  };

  policies.Preferences =
  {
    "browser.tabs.tabMinWidth" = 50; # Make tabs able to be smaller to prevent scrolling

    "browser.newtabpage.activity-stream.feeds.section.topstories" = false; # No recommended stories
    "browser.newtabpage.activity-stream.feeds.topsites" = false; # No stupid top sites

    "browser.newtabpage.activity-stream.section.highlights.includePocket" = false; # Disable stupid pocket stuff
    "browser.urlbar.suggest.quicksuggest.sponsored" = false; # No sponsored suggestions

    "browser.urlbar.placeholderName" = "DuckDuckGo";
    "browser.urlbar.placeholderName.private" = "DuckDuckGo";

    "browser.aboutConfig.showWarning" = false; # No warning when going to config

    "browser.uiCustomization.state" =
    ''
    {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":[],"nav-bar":["back-button","forward-button","stop-reload-button","urlbar-container","downloads-button","fxa-toolbar-menu-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button"],"dirtyAreaCache":["nav-bar"],"currentVersion":20,"newElementCount":3}
    ''; # Make toolbar only have what I want
    "browser.download.autohideButton" = false; # Never hide downloads button
    "media.videocontrols.picture-in-picture.video-toggle.enabled" = false; # Disable picture in picture;

    "services.sync.engine.addons" = false; # Don't sync addons
    "services.sync.engine.prefs" = false; # Don't sync settings
    "services.sync.engine.prefs.modified" = false; # Don't sync more settings
    "services.sync.engine.bookmarks" = false; # Don't sync bookmarks
    "services.sync.declinedEngines" = "prefs,bookmarks,addons"; # Decline everything more

    "browser.download.useDownloadDir" = false; # Don't ask where to download things
    "browser.tabs.loadInBackground" = true; # Load tabs automaticlaly
    "mousewheel.system_scroll_override" = true; # SCROLL NORMALLY FFS

    "browser.in-content.dark-mode" = true; # Use dark mode
    "ui.systemUsesDarkTheme" = true;

    "extensions.autoDisableScopes" = 0; # Automatically enable extensions
    "extensions.update.enabled" = false; # Don't update extensions since they're sourced from rycee
  };

  search =
  {
    force = true;
    default = "DuckDuckGo";
  };

  ryceeAddons = with inputs.firefox-addons.packages.${pkgs.system};
  [
    ublock-origin

    sponsorblock
    return-youtube-dislikes
    indie-wiki-buddy
    modrinthify

    # bypass-paywalls-clean (can't use, was creating popups)
    consent-o-matic
    terms-of-service-didnt-read

    auto-tab-discard
    clearurls
    link-cleaner

    redirector # For nixos wiki
    movie-web # Thanks rycee

  ];

  customAddons =
  [

  ];




in
{
  programs.firefox =
  {
    enable = true;
    inherit package policies;
    profiles.default =
    {
      isDefault = true;
      extensions = ryceeAddons ++ customAddons;
      inherit search;
    };

  };


}
