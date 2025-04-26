{ lib, config, ... }:
{
  hm.programs.plasma.panels = lib.singleton
  {
    location = "bottom";
    widgets =
    [
      {
        kickoff.icon = "nix-snowflake-white";
      }

      {
        iconTasks.launchers = map
          (item: "applications:" + item)
          config.features.taskbar;
      }

      # If no configuration is needed, specifying only the name of the
      # widget will add them with the default configuration.
      "org.kde.plasma.marginsseparator"
      {
        systemTray.items =
        {
          shown =
          [
            "org.kde.plasma.battery"
            "org.kde.plasma.clipboard"
            "org.kde.plasma.networkmanagement"
            "org.kde.plasma.volume"
          ];
          hidden =
          [
            "org.kde.plasma.brightness"
          ];
        };
      }

      "org.kde.plasma.digitalclock"
    ];
  };
}
