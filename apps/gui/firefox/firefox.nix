{ pkgs, ...}:

{
  # Change if we ever stop using Firefox (unlikely)
  features.browser = "firefox";

  hm.programs.firefox =
  {
    enable = true;

    package = pkgs.firefox;

    profiles.default =
    {
      isDefault = true;
      search =
      {
        force = true;
        default = "DuckDuckGo";
      };

      settings =
      {
        # Normal firefox settings that happen to be blocked with policies
        "services.sync.declinedEngines" = "";

        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "";
      };
    };
  };

  hm.home.file.".mozilla/firefox/profiles.ini".force = true;

  # `man` likes having this
  environment.variables.BROWSER = "firefox";
}
