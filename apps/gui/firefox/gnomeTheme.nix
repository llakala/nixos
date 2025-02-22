{ lib, inputs, ... }:

# Disabled for now, since vertical tab behavior is super buggy and doesn't let me scroll
# See https://github.com/rafaelmardojai/firefox-gnome-theme/issues/820
{
  # hm.programs.firefox.profiles.default =
  # {
  #   userChrome =
  #   ''
  #     @import "firefox-gnome-theme/userChrome.css";
  #   '';
  #
  #   userContent =
  #   ''
  #     @import "firefox-gnome-theme/userContent.css";
  #   '';
  #
  #   extraConfig = lib.readFile "${inputs.firefox-gnome-theme}/configuration/user.js";
  #
  #   settings =
  #   {
  #     "gnomeTheme.activeTabContrast" = true;
  #     "gnomeTheme.normalWidthTabs" = true;
  #     "gnomeTheme.hideSingleTab" = false;
  #   };
  # };
  #
  # hm.home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
}
