{ pkgs-unstable, lib, config, pkgs, self, ... }:

{
  hm.programs.helix.languages.language-server =
  {
    mdpls.command = lib.getExe self.packages.${pkgs.system}.mdpls;

    bash-language-server.command = lib.getExe pkgs.nodePackages.bash-language-server;

    vscode-json-language-server =
    {
      command = lib.getExe pkgs.nodePackages.vscode-json-languageserver;
      args = [ "--stdio" ];
      config.provideFormatter = false;
    };

    vim-language-server =
    {
      command = lib.getExe pkgs.vim-language-server;
      args = lib.singleton "--stdio";
    };
  };


  hm.programs.helix.languages.language-server.nixd =
  let
    flake = "(builtins.getFlake \"${config.baseVars.configDirectory}\")";
    hostOptions = flake + ".nixosConfigurations.${config.hostVars.hostName}.options";
  in
  {
    command = lib.getExe pkgs-unstable.nixd;
    args =
    [
      "--inlay-hints=true"
      "--semantic-tokens=true"
    ];
    config.nixd = # DON'T MESS THIS KEY UP, IT WAS WHY THINGS WERE FAILING
    {
      options.nixos.expr = hostOptions;
    };
  };
}