{ lib, pkgs, pkgs-unstable, self, config, ... }:

{
  hm.programs.helix.languages.language =
  [
    {
      name = "nix";
      auto-format = false;
      language-servers = lib.singleton "nixd";
    }

    {
      name = "markdown";
      auto-format = false;
      language-servers = [ "mdpls" ];
    }

    {
      name = "json";
      auto-format = false;
      language-servers = lib.singleton "vscode-json-language-server";
    }
  ];
}
