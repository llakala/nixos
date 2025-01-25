{ lib, pkgs, ... }:

{
  hm.programs.helix.languages.language =
  [
    {
      name = "nix";
      auto-format = false;
      language-servers = lib.singleton "nixd";
      formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
    }

    {
      name = "markdown";
      auto-format = false;
      language-servers = [ "marksman" "mdpls" ];
      soft-wrap.enable = true;
    }

    {
      name = "hyprlang";
      file-types =
      [
        { glob = "hypr/*.conf"; }
        { glob = "*.hypr.conf"; }
      ];
    }

    {
      name = "java";
      auto-format = false;

      language-servers = lib.singleton "jdtls";

      indent =
      {
        tab-width = 4;
        unit = "    ";
      };

      formatter =
      {
        command = lib.getExe pkgs.google-java-format;
        args =
        [
          "--aosp" # Android code style
           "-" # Read from stdin, required
        ];
      };
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

    {
      name = "fish";
      language-servers = lib.singleton "fish-lsp";
    }


    {
      name = "bash";
      language-servers = lib.singleton "bash-language-server";

      formatter =
      {
        command = lib.getExe pkgs.shfmt;
        args =
        [
          "-i" "2" # 2 spaces, not tabs
          "--func-next-line" # Allman style brackets, as life should be
          "--case-indent"
        ];
      };

    }

  ];
}
