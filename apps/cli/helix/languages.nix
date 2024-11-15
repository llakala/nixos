{ lib, ... }:

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
      language-servers = [ "marksman" "mdpls" ];
    }

    {
      name = "json";
      auto-format = false;
      language-servers = lib.singleton "vscode-json-language-server";
    }

    {
      name = "python";
      auto-format = false;
      language-servers = lib.singleton "pylsp";
    }

    {
      name = "vim";
      scope = "source.vim";
      file-types =
      [
        "vim"
        { glob = ".vimrc"; }
      ];
      roots = lib.singleton "addon-info.json";
      comment-token = "\"";
      language-servers = lib.singleton "vim-language-server";
    }

    {
      name = "toml";
      auto-format = false;
      language-servers = lib.singleton "taplo";
    }

  ];
}
