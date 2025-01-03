{ pkgs, inputs, lib, ...}:

{
  hm.programs.firefox =
  {
    enable = true;

    package = pkgs.firefox.overrideAttrs
    (oldAttrs:
    {
      buildCommand = oldAttrs.buildCommand +
      /* bash */
      ''
      wrapProgram $out/bin/firefox \
        --set MOZ_LOG "PlatformDecoderModule:5"
      '';
    });


    profiles.default =
    {
      isDefault = true;
      search =
      {
        force = true;
        default = "DuckDuckGo";
      };
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
      extraConfig = lib.readFile "${inputs.firefox-gnome-theme}/configuration/user.js";

      settings = # Settings that aren't allowed to be set in policies
      {
        "gnomeTheme.activeTabContrast" = true;
        "gnomeTheme.normalWidthTabs" = true;
        "gnomeTheme.hideSingleTab" = false;

        # Normal firefox settings that happen to be blocked with policies
        "services.sync.declinedEngines" = "";

        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "";
      };
    };
  };

  hm.home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;

  environment.variables.BROWSER = "firefox"; # `man` likes having this
}
