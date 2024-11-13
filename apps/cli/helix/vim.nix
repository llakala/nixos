{ pkgs, lib, ... }:

let
  url = "https://github.com/tree-sitter-grammars/tree-sitter-vim";
  rev = "f3cd62d8bd043ef20507e84bb6b4b53731ccf3a7";
in
{
  hm.programs.helix.languages.grammar = lib.singleton
  {
    name = "vim";
    source =
    {
      git = url;
      inherit rev;
    };
  };

  hm.programs.helix.languages.language = lib.singleton
  {
    name = "vim";
    scope = "source.vim";
    file-types =
    [
      "vim"
      {
        glob = ".vimrc";
      }
    ];
    roots = lib.singleton "addon-info.json";
    comment-token = "\"";
    language-servers = lib.singleton
    {
      name = "vim-language-server";
    };
  };

  hm.programs.helix.languages.language-server.vim-language-server =
  {
    command = lib.getExe pkgs.vim-language-server;
    args = lib.singleton "--stdio";
  };
}