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



  policies =
  {
    DontCheckDefaultBrowser = true;
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableFirefoxScreenshots = true;

    DisplayBookmarksToolbar = "never";
    DisplayMenuBar = "never"; # Previously appeared when pressing alt

    OverrideFirstRunPage = "";
    PictureInPicture.Enabled = false;
    PromptForDownloadLocation = false;

    HardwareAcceleration = true;
    TranslateEnabled = true;

    Homepage.StartPage = "previous-session";

    UserMessaging =
    {
      UrlbarInterventions = false;
      SkipOnboarding = true;
    };

    FirefoxSuggest =
    {
      WebSuggestions = false;
      SponsoredSuggestions = false;
      ImproveSuggest = false;
    };

    EnableTrackingProtection =
    {
      Value = true;
      Cryptomining = true;
      Fingerprinting = true;
    };

    FirefoxHome = # Make new tab only show search
    {
      Search = true;
      TopSites = false;
      SponsoredTopSites = false;
      Highlights = false;
      Pocket = false;
      SponsoredPocket = false;
      Snippets = false;
    };
  };

  policies.Handlers."schemes" =
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



  search =
  {
    force = true;
    default = "DuckDuckGo";
  };

  search.engines =
  {
    # Disable all the stupid "This time, search with" icons
    "Google".metaData.hidden = true;
    "Bing".metaData.hidden = true;
    "eBay".metaData.hidden = true;
    "Amazon.com".metaData.hidden = true;
    "Wikipedia (en)".metaData.hidden = true;

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

    "Noogle" =
    {
      urls = lib.singleton
      {
        template =  "https://noogle.dev/q?term={searchTerms}";
      };
      definedAliases = [ "@nog" ];
    };

  };



  policies.Preferences =
  {
    "browser.urlbar.suggest.searches" = true; # Need this for basic search suggestions
    "browser.urlbar.shortcuts.bookmarks" = false;
    "browser.urlbar.shortcuts.history" = false;
    "browser.urlbar.shortcuts.tabs" = false;

    "browser.tabs.tabMinWidth" = 75; # Make tabs able to be smaller to prevent scrolling

    "browser.urlbar.placeholderName" = "DuckDuckGo";
    "browser.urlbar.placeholderName.private" = "DuckDuckGo";

    "browser.aboutConfig.showWarning" = false; # No warning when going to config
    "browser.warnOnQuitShortcut" = false;

    "browser.tabs.loadInBackground" = true; # Load tabs automaticlaly

    "browser.in-content.dark-mode" = true; # Use dark mode
    "ui.systemUsesDarkTheme" = true;

    "extensions.autoDisableScopes" = 0; # Automatically enable extensions
    "extensions.update.enabled" = false; # Don't update extensions since they're sourced from rycee

    "widget.use-xdg-desktop-portal.file-picker" = 1; # Use new gtk file picker instead of legacy one
  };

  policies.Preferences."browser.uiCustomization.state" = builtins.toJSON
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



  ryceeAddons = with inputs.firefox-addons.packages.${pkgs.system};
  [
    ublock-origin
    sponsorblock
    return-youtube-dislikes
    indie-wiki-buddy

    modrinthify
    refined-github
    movie-web

    # bypass-paywalls-clean (can't use, was creating popups)
    consent-o-matic
    terms-of-service-didnt-read

    auto-tab-discard
    clearurls
    link-cleaner

    redirector # For nixos wiki
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

    settings = # Settings that aren't allowed to be set in policies
    {
      "gnomeTheme.activeTabContrast" = true;
      "gnomeTheme.normalWidthTabs" = true;

      # Settings recommended by firefox-gnome-theme
      "widget.gtk.rounded-bottom-corners.enabled" = true;
      "browser.uidensity" = 0;

      # Normal firefox settings that happen to be blocked
      "mousewheel.system_scroll_override" = true; # Normal system scrolling
      "reader.parse-on-load.enabled" = false; # Disable Reader View
    };
  };

  home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
}