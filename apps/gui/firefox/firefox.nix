{ pkgs, inputs, lib, ...}:

let

  ryceeAddons = with inputs.firefox-addons.packages.${pkgs.system};
  [
    ublock-origin
    sponsorblock
    return-youtube-dislikes
    indie-wiki-buddy

    modrinthify
    refined-github
    movie-web

    # bypass-paywalls-clean (can't use, was creating popups)
    consent-o-matic
    terms-of-service-didnt-read

    auto-tab-discard
    clearurls
    link-cleaner

    redirector # For nixos wiki
    darkreader
  ];

  customAddons =
  [

  ];
in
{
  hm.programs.firefox =
  {
    enable = true;

    package = pkgs.firefox.overrideAttrs
    (oldAttrs:
    {
      buildCommand = oldAttrs.buildCommand +
      # bash
      ''
      wrapProgram $out/bin/firefox \
        --set MOZ_LOG "PlatformDecoderModule:5"
      '';
    });


    profiles.default =
    {
      isDefault = true;
      extensions = ryceeAddons ++ customAddons;
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

        # Normal firefox settings that happen to be blocked
        "mousewheel.system_scroll_override" = true; # Normal system scrolling
        "services.sync.declinedEngines" = "";
      };
    };
  };

  hm.home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;
}
