{
  features.browser = "firefox"; # Change if we ever stop using Firefox (unlikely)

  hm.programs.firefox = {
    enable = true;

    profiles.default = {
      isDefault = true;
      search = {
        force = true;

        # DuckDuckGo has been excruciatingly awful lately
        default = "google";
      };

      settings = {
        # Normal firefox settings that happen to be blocked with policies
        "services.sync.declinedEngines" = "";

        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "";
      };
    };
  };

  hm.home.file.".mozilla/firefox/profiles.ini".force = true;

  environment.variables.BROWSER = "firefox"; # `man` likes having this
}
