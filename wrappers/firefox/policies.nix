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

  UserMessaging = {
    UrlbarInterventions = false;
    SkipOnboarding = true;
  };

  FirefoxSuggest = {
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
  };

  EnableTrackingProtection = {
    Value = true;
    Cryptomining = true;
    Fingerprinting = true;
  };

  # Make new tab only show search
  FirefoxHome = {
    Search = true;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    SponsoredPocket = false;
    Snippets = false;
  };

  Handlers.schemes.vscode = {
    action = "useSystemDefault";
    ask = false;
  };

  Handlers.schemes.element = {
    action = "useSystemDefault";
    ask = false;
  };

  # TODO: make sure this works
  "3rdparty".extensions = {
    "gdpr@cavi.au.dk" = {
      "permissions" = [ "<all_urls>" ];
      "origins" = [ "<all_urls>" ];
    };
  };
}
