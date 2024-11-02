{ lib, pkgs, self, ... }:

{
  hm.programs.helix.languages.language =
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

  hm.programs.helix.languages.language-server = # Define language server executables here so helix can access them
  {
    nil.command = lib.getExe pkgs.nil;

    # We don't pass the pylsp exe, instead using the one from helix.extraPackages

    mdpls.command = lib.getExe self.packages.${pkgs.system}.mdpls;

    bash-language-server.command = lib.getExe pkgs.nodePackages.bash-language-server;

    vscode-json-language-server =
    {
      command = lib.getExe pkgs.nodePackages.vscode-json-languageserver;
      args = [ "--stdio" ];
      config.provideFormatter = false;
    };
  };

  hm.programs.helix.extraPackages =
  let
    pylspInstance = pkgs.python3.withPackages
    (
      ps:
      [ ps.python-lsp-server ]
      ++ ps.python-lsp-server.optional-dependencies.all
    );
  in
    lib.singleton pylspInstance;
}
