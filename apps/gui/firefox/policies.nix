{
  hm.programs.firefox.policies =
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

    Handlers.schemes.vscode =
    {
      action = "useSystemDefault"; # Open VSCode app
      ask = false;
    };

    Handlers.schemes.element =
    {
      action = "useSystemDefault"; # Open Element app
      ask = false;
    };

    "3rdparty".extensions."uBlock0@raymondhill.net" =
    {
      permissions = [ "internal:privateBrowsingAllowed" ];
      origins = [];
    };

    "3rdparty".extensions."{b0a674f9-f848-9cfd-0feb-583d211308b0}" = # Movie-web
    {
      "permissions" = [ "<all_urls>" ];
      "origins" = [ "<all_urls>" ];
    };

    "3rdparty".extensions."gdpr@cavi.au.dk" =
    {
      "permissions" = [ "<all_urls>" ];
      "origins" = [ "<all_urls>" ];
    };
  };

}
