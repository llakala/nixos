{ pkgs, hostVars, ...}:

{

  programs.firefox =
  {
    enable = true;

    package = (pkgs.wrapFirefox pkgs.firefox-unwrapped
    {

    })

    .overrideAttrs (oldAttrs:
    {
      buildCommand = oldAttrs.buildCommand +
      ''
      wrapProgram $out/bin/firefox \
        --set MOZ_ENABLE_WAYLAND 0 \
        --set MOZ_USE_XINPUT2 1
      '';
    });
  };


  programs.firefox.profiles.${hostVars.username} =
  {
    isDefault = true;
    settings =
    {
      "browser.startup.page" = 3; # Restore last tabs
      "browser.aboutConfig.showWarning" = false; # No warning when going to config

      "browser.urlbar.placeholderName" = "DuckDuckGo";
      "browser.urlbar.placeholderName.private" = "DuckDuckGo";

      "privacy.donottrackheader.enabled" = false; # Don't track me
      "privacy.globalprivacycontrol.enabled" = true; # Don't sell or share my data

      "browser.urlbar.suggest.quicksuggest.sponsored" = false; # No sponsored suggestions
      "browser.newtabpage.activity-stream.feeds.section.topstories" = false; # No recommended stories
      "browser.newtabpage.activity-stream.feeds.topsites" = false; # No stupid top sites
      "browser.newtabpage.activity-stream.section.highlights.includePocket" = false; # Disable stupid pocket stuff
    };
  };



}