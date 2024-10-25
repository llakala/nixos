{ lib, pkgs, inputs, ... }:
{
  hm.programs.helix.languages =
  {
    language =
    [
      {
        name = "nix";
        auto-format = false;
        language-servers = lib.singleton "nil";
      }
      {
        name = "python";
        auto-format = false;
        language-servers = lib.singleton "pylsp";
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

    language-server = # Define language server executables here so helix can access them
    {
      nil.command = lib.getExe pkgs.nil;

      pylsp.command = lib.getExe pkgs.python3Packages.python-lsp-server;

      mdpls.command = lib.getExe inputs.self.packages.${pkgs.system}.mdpls;

      vscode-json-language-server =
      {
        command = lib.getExe pkgs.nodePackages.vscode-json-languageserver;
        args = [ "--stdio" ];
        config.provideFormatter = false;
      };
    };

  };

}
