{ pkgs-unstable, lib, config, pkgs, self, ... }:

{
  hm.programs.helix.languages.language-server =
  {
    typescript-language-server.command = lib.getExe pkgs.nodePackages.typescript-language-server;

    taplo.command = lib.getExe pkgs.taplo; # taplo-lsp is just an alias for taplo

    fish-lsp =
    {
      command = lib.getExe pkgs.fish-lsp;
      args = lib.singleton "start";
    };

    jdtls =
    {
      command = lib.getExe pkgs.jdt-language-server;

      config =
      {
        java.inlayHints.parameterNames.enabled = "none";
      };
    };

    marksman.command = lib.getExe pkgs.marksman;
    mdpls =
    {
      command = lib.getExe self.legacyPackages.${pkgs.system}.mdpls;
      config.markdown.preview = # https://github.com/euclio/mdpls?tab=readme-ov-file#configuration
      {
        auto = true; # Automatically open preview in browser when opening file
        serveStatic = true; # Show images
      };
    };

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

    bash-language-server =
    {
      command = lib.getExe pkgs.nodePackages.bash-language-server;
      environment.SHELLCHECK_ARGUMENTS = "-e SC2164"; # Couldn't get `config` block to work, so this is the best way to disable certain shellchecks in linting
    };

    solargraph =
    {
      command = lib.getExe pkgs.rubyPackages.solargraph;
      args = lib.singleton "stdio";
    };
  };


  hm.programs.helix.languages.language-server.nixd =
  let
    flake = "(builtins.getFlake \"${config.hostVars.configDirectory}\")";
    hostOptions = flake + ".nixosConfigurations.${config.hostVars.hostName}.options";
  in
  {
    command = lib.getExe pkgs-unstable.nixd;
    args =
    [
      "--inlay-hints=false" # Don't need package versions
      "--semantic-tokens=true"
    ];
    config.nixd = # DON'T MESS THIS KEY UP, IT WAS WHY THINGS WERE FAILING
    {
      options.nixos.expr = hostOptions;
    };
  };
}
