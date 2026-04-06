{

  hm.programs.plasma.shortcuts = {
    "services/org.kde.krunner.desktop"._launch = "Meta";
    "plasmashell"."activate application launcher" = "none";
  };

  hm.programs.plasma.configFile.krunnerrc = {
    General = {
      FreeFloating = true;
      historyBehavior = "Disabled";
    };

    "Plugins/Favorites".plugins = "krunner_powerdevil,krunner_sessions,windows,krunner_services,krunner_systemsettings";
    Plugins = {
      krunner_powerdevilEnabled = true;
      krunner_sessionsEnabled = true;
      windowsEnabled = true;
      krunner_servicesEnabled = true;
      krunner_systemsettingsEnabled = true;

      krunner_shellEnabled = false;
      baloosearchEnabled = false;
      calculatorEnabled = false;
      helprunnerEnabled = false;
      krunner_appstreamEnabled = false;
      krunner_bookmarksrunnerEnabled = false;
      krunner_charrunnerEnabled = false;
      krunner_colorsEnabled = false;
      krunner_dictionaryEnabled = false;
      krunner_katesessionsEnabled = false;
      krunner_killEnabled = false;
      krunner_konsoleprofilesEnabled = false;
      krunner_kwinEnabled = false;
      krunner_placesrunnerEnabled = false;
      krunner_plasma-desktopEnabled = false;
      krunner_recentdocumentsEnabled = false;
      krunner_spellcheckEnabled = false;
      krunner_webshortcutsEnabled = false;
      locationsEnabled = false;
      "org.kde.activities2Enabled" = false;
      "org.kde.datetimeEnabled" = false;
      unitconverterEnabled = false;
    };
  };

}
