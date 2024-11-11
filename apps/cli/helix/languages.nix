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
    nixd.command = lib.getExe pkgs-unstable.nixd;
    nixd.args =
    [
      "--inlay-hints=true"
      "--semantic-tokens=true"
    ];
    nixd.config.nixd = # DON'T MESS THIS KEY UP, IT WAS WHY THINGS WERE FAILING
    let
      flake = "(builtins.getFlake \"${config.baseVars.configDirectory}\")";
      hostOptions = flake + ".nixosConfigurations.${config.hostVars.hostName}.options";
    in
    {
      options.nixos.expr = hostOptions;
    };

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
