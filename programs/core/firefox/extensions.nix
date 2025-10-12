{ sources, pkgs, ... }:

let
  rycee-exprs = import "${sources.firefox-addons}/default.nix" { inherit pkgs; };

  # Search extension names with below command:
  # nix flake show --json "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons" --all-systems | jq -r '.packages."x86_64-linux" | keys[]' | rg QUERY
  ryceeAddons = with rycee-exprs.firefox-addons; [
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
    # clearurls # Buggy with github search, not sure why
    link-cleaner

    redirector # For nixos wiki
    darkreader
  ];

  customAddons = [

  ];
in {
  hm.programs.firefox.profiles.default = {
    extensions.packages = ryceeAddons ++ customAddons;
  };

  hm.programs.firefox.policies."3rdparty".extensions = {
    "uBlock0@raymondhill.net" = {
      permissions = [ "internal:privateBrowsingAllowed" ];
      origins = [];
    };

    # Movie-web
    "{b0a674f9-f848-9cfd-0feb-583d211308b0}" = {
      "permissions" = [ "<all_urls>" ];
      "origins" = [ "<all_urls>" ];
    };

    "gdpr@cavi.au.dk" = {
      "permissions" = [ "<all_urls>" ];
      "origins" = [ "<all_urls>" ];
    };
  };
}
