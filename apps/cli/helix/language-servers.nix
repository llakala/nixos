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


  # Code referenced from:
  # https://github.com/maxbrunet/dotfiles/blob/9a114ea0f9c8cdeb0f07d762f329bdbbe2973e50/nix/common.nix#L138
  # https://github.com/NixOS/nixpkgs/issues/229337#issuecomment-1877951362
  hm.programs.helix.languages.language-server.pylsp =
  let
    oldlsp = pkgs.python3Packages.python-lsp-server;
    newlsp = oldlsp.overridePythonAttrs
    (oldAttrs:
      {
        propagatedBuildInputs =
          (oldAttrs.propagatedBuildInputs or [])
          ++ oldlsp.optional-dependencies.all; # A list of bundled pylsp plugins
      }
    );
  in
  {
    command = newlsp;
    config.pylsp.plugins =
    {
      pycodestyle.enabled = true;
    };
  };
}