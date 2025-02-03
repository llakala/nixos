{ lib, ... }:

{
  hm.programs.firefox.profiles.default.search.engines =
  {
    # Disable all the stupid "This time, search with" icons
    "Google".metaData.hidden = true;
    "Bing".metaData.hidden = true;
    "eBay".metaData.hidden = true;
    "Amazon.com".metaData.hidden = true;
    "Wikipedia (en)".metaData.hidden = true;

    # Thanks to xunuwu on github for being a reference for use of these functions
    "Github Search Nix" =
    {
      urls = lib.singleton
      {
        template = "https://github.com/search?type=code&q=lang:nix+NOT+is:fork+{searchTerms}";
      };

      iconUpdateURL = "https://github.com/favicon.ico";
      definedAliases = lib.singleton "@gn";
    };


    "Github Search" =
    {
      urls = lib.singleton
      {
        template = "https://github.com/search?type=code&q=NOT+is:fork+{searchTerms}";
      };

      iconUpdateURL = "https://github.com/favicon.ico";
      definedAliases = lib.singleton "@gh";
    };

    "Github Search Fish" =
    {
      urls = lib.singleton
      {
        template = "https://github.com/search?type=code&q=lang:fish+NOT+is:fork+{searchTerms}";
      };

      iconUpdateURL = "https://fishshell.com/favicon.ico";
      definedAliases = lib.singleton "@gf";
    };

    "Noogle" =
    {
      urls = lib.singleton
      {
        template = "https://noogle.dev/q?term={searchTerms}";
      };

      iconUpdateURL = "https://noogle.dev/favicon.png";
      definedAliases = lib.singleton "@ng";
    };

    "Nixpkgs" =
    {
      urls = lib.singleton
      {
        template = "https://github.com/search?type=code&q=repo:NixOS/nixpkgs+lang:nix+{searchTerms}";
      };

      definedAliases = lib.singleton "@npkgs";
    };

    "Home Manager" =
    {
      urls = lib.singleton
      {
        template = "https://github.com/search?type=code&q=repo:nix-community/home-manager+lang:nix+{searchTerms}";
      };

      definedAliases = lib.singleton "@hmgr";
    };


    "Home Manager Options" =
    {
      urls = lib.singleton
      {
        template = "https://home-manager-options.extranix.com/?release=release-24.11&query={searchTerms}";
      };

      iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.png";
      definedAliases = lib.singleton "@oh";
    };

    "NixOS Options" =
    {
      urls = lib.singleton
      {
        template = "https://search.nixos.org/options?channel=24.11&from=0&size=100&sort=alpha_asc&query={searchTerms}";
      };

      definedAliases = lib.singleton "@on";
    };

  };
}
