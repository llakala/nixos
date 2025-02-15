{
  features.discord = "vesktop"; # Change if we ever stop using vesktop

  custom.programs.vesktop =
  {
    enable = true;

    # Vesktop settings, ~/.config/vesktop/settings.json
    settings =
    {
      tray = false;
      hardwareAcceleration = true;
      discordBranch = "stable";
    };

    # Vencord settings, ~/.config/vesktop/settings/settings.json
    vencord.settings =
    {

    };
  };
}
