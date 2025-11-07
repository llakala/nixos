{
  Remove = [
    "DuckDuckGo"
    "Bing"
    "eBay"
    "Amazon.com"
    "Wikipedia (en)"
    "Google"
    "Perplexity"
  ];
  Default = "Google (udm14)";
  Add = [
    {
      Name = "Google (udm14)";
      URLTemplate = "https://www.google.com/search?q={searchTerms}&udm=14";
      IconURL = "https://www.google.com/favicon.ico";
    }
    {
      Name = "Github Search Nix";
      URLTemplate = "https://github.com/search?type=code&q=lang:nix+NOT+is:fork+{searchTerms}";
      IconURL = "https://github.com/favicon.ico";
      Alias = "@gn";
    }
    {
      Name = "Github Search";
      URLTemplate = "https://github.com/search?type=code&q=NOT+is:fork+{searchTerms}";
      IconURL = "https://github.com/favicon.ico";
      Alias = "@gh";
    }
    {
      Name = "Github Search Fish";
      URLTemplate = "https://github.com/search?type=code&q=lang:fish+NOT+is:fork+{searchTerms}";
      IconURL = "https://fishshell.com/favicon.ico";
      Alias = "@gf";
    }
    {
      Name = "Github Search Lua";
      URLTemplate = "https://github.com/search?type=code&q=lang:lua+NOT+is:fork+{searchTerms}";
      IconURL = "https://github.com/favicon.ico";
      Alias = "@gl";
    }
    {
      Name = "Github Search Gleam";
      URLTemplate = "https://github.com/search?type=code&q=lang:gleam+NOT+is:fork+{searchTerms}";
      IconURL = "https://github.com/favicon.ico";
      Alias = "@gg";
    }
    {
      Name = "Github Search Typst";
      URLTemplate = "https://github.com/search?type=code&q=lang:typst+NOT+is:fork+{searchTerms}";
      IconURL = "https://github.com/favicon.ico";
      Alias = "@gt";
    }
    {
      Name = "Noogle";
      URLTemplate = "https://noogle.dev/q?term={searchTerms}";
      IconURL = "https://noogle.dev/favicon.png";
      Alias = "@ng";
    }
    {
      Name = "Nixpkgs";
      URLTemplate = "https://github.com/search?type=code&q=repo:NixOS/nixpkgs+lang:nix+{searchTerms}";
      Alias = "@npkgs";
    }
    {
      Name = "Home Manager";
      URLTemplate = "https://github.com/search?type=code&q=repo:nix-community/home-manager+lang:nix+{searchTerms}";
      Alias = "@hmgr";
    }
    {
      Name = "Home Manager Options";
      URLTemplate = "https://home-manager-options.extranix.com/?release=master&query={searchTerms}";
      IconURL = "https://home-manager-options.extranix.com/images/favicon.png";
      Alias = "@oh";
    }
    {
      Name = "NixOS Options";
      URLTemplate = "https://search.nixos.org/options?channel=unstable&from=0&size=100&sort=alpha_asc&query={searchTerms}";
      Alias = "@on";
    }
  ];
}
