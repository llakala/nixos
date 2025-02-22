{ lib, inputs, ... }:

{
  hm.programs.firefox.profiles.default =
  {
    userChrome =
    ''
      @import "firefox-gnome-theme/userChrome.css";
    '';

    userContent =
    ''
      @import "firefox-gnome-theme/userContent.css";
    '';

    extraConfig = lib.readFile "${inputs.firefox-gnome-theme}/configuration/user.js";

    settings =
    {
      "gnomeTheme.activeTabContrast" = true;
      "gnomeTheme.normalWidthTabs" = true;
      "gnomeTheme.hideSingleTab" = false;
    };
  };

  hm.home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
}
