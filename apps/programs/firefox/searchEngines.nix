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
    "Github Nix Code" =
    {
      urls = lib.singleton
      {
        template = "https://github.com/search";
        params = lib.attrsToList # Thanks to xunuwu on github for being a reference to use of these functions
        {
          "type" = "code";
          "q" = "lang:nix NOT is:fork {searchTerms}";
        };
      };

      iconUpdateURL = "https://github.com/favicon.ico";
      definedAliases = [ "@gn" ];
    };


    "Github Search Code" =
    {
      urls = lib.singleton
      {
        template = "https://github.com/search";
        params = lib.attrsToList # Thanks to xunuwu on github for being a reference to use of these functions
        {
          "type" = "code";
          "q" = "NOT is:fork {searchTerms}";
        };
      };

      iconUpdateURL = "https://github.com/favicon.ico";
      definedAliases = [ "@gs" ];
    };

    "MyNixOS" =
    {
      urls = lib.singleton
      {
        template = "https://mynixos.com/search";
        params = lib.attrsToList
        {
          "q" = "{searchTerms}";
        };
      };
      definedAliases = [ "@mn" ];
    };

    "Noogle" =
    {
      urls = lib.singleton
      {
        template =  "https://noogle.dev/q?term={searchTerms}";
      };
      definedAliases = [ "@ng" ];
    };

    "Nixpkgs" =
    {
      urls = lib.singleton
      {
        template = "https://github.com/search";
        params = lib.attrsToList
        {
          "type" = "code";
          "q" = "repo:NixOS/nixpkgs lang:nix {searchTerms}";
        };
      };
      definedAliases = [ "@npkgs" ];
    };

  };
}
