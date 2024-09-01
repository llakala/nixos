{ pkgs, inputs, lib, ...}:

let
  package = pkgs.firefox.overrideAttrs # Bug fixed on firefox 130: wait for fix
  (oldAttrs:
  {
    buildCommand = oldAttrs.buildCommand +
    ''
    wrapProgram $out/bin/firefox \
      --set MOZ_ENABLE_WAYLAND 0 \
      --set MOZ_USE_XINPUT2 1
    '';
  });

  engines =
  {
    "Github Nix Code" =
    {
      urls = lib.singleton
      {
        template = "https://github.com/search";
        params = lib.attrsToList # Thanks to xunuwu on github for being a reference to use of these functions
        {
          "type" = "code";
          "q" = "lang:nix NOT is:fork {searchTerms}";
        };
      };

      iconUpdateURL = "https://github.com/favicon.ico";
      definedAliases = [ "@ghn" ];
    };

    "MyNixOS" =
    {
      urls = lib.singleton
      {
        template = "https://mynixos.com/search";
        params = lib.attrsToList
        {
          "q" = "{searchTerms}";
        };
      };

      definedAliases = [ "@mn" ];
    };
  };

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
    {
      "placements":
      {
        "widget-overflow-fixed-list":[],
        "unified-extensions-area":
        [
          "sponsorblocker_ajay_app-browser-action","ublock0_raymondhill_net-browser-action","gdpr_cavi_au_dk-browser-action","redirector_einaregilsson_com-browser-action","_5183707f-8a46-4092-8c1f-e4515bcebbad_-browser-action","_b0a674f9-f848-9cfd-0feb-583d211308b0_-browser-action","jid0-3guet1r69sqnsrca5p8kx9ezc3u_jetpack-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","_c2c003ee-bd69-42a2-b0e9-6f34222cb046_-browser-action","_cb31ec5d-c49a-4e5a-b240-16c767444f62_-browser-action"
        ],
        "nav-bar":
        [
          "back-button",
          "forward-button",
          "stop-reload-button",
          "urlbar-container",
          "downloads-button",
          "fxa-toolbar-menu-button",
          "unified-extensions-button"
        ],
        "toolbar-menubar":["menubar-items"],
        "TabsToolbar":
        [
          "firefox-view-button",
          "tabbrowser-tabs",
          "new-tab-button"
        ],
        "PersonalToolbar":["personal-bookmarks"]
      },
      "currentVersion":20,
      "newElementCount":3
    }
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

    "widget.use-xdg-desktop-portal.file-picker" = 1; # Use new gtk file picker instead of legacy one
  };

  search =
  {
    force = true;
    default = "DuckDuckGo";
    inherit engines;
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

    refined-github

    darkreader

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
  };

  programs.firefox.profiles.default =
    {
      isDefault = true;
      extensions = ryceeAddons ++ customAddons;
      inherit search;
    userChrome = ''
      @import "firefox-gnome-theme/userChrome.css";
    '';
    userContent = ''
      @import "firefox-gnome-theme/userContent.css";
    '';
  };

  home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
}
