{
  hm.programs.firefox.policies =
  {
    DontCheckDefaultBrowser = true;
    DisableTelemetry = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableFirefoxScreenshots = true;

    DisplayBookmarksToolbar = "never";

    # Previously appeared when pressing alt
    DisplayMenuBar = "never";

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

    # Make new tab only show search
    FirefoxHome =
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
      # Open VSCode app
      action = "useSystemDefault";
      ask = false;
    };

    Handlers.schemes.element =
    {
      # Open Element app
      action = "useSystemDefault";
      ask = false;
    };
  };

}
