{ types, ... }:

{
  inputs = {
    self.from = { parent }: parent.self;
  };

  options = {
    package.defaultFunc =
      { inputs }:
      let
        inherit (inputs.nixpkgs.pkgs) neovim-unwrapped fetchFromGitHub;
      in
      neovim-unwrapped.overrideAttrs (oldAttrs: {
        doCheck = false;
        doInstallCheck = false;
        src = fetchFromGitHub {
          owner = "neovim";
          repo = "neovim";
          rev = "97a524e8bc89cbdfad3355443774936cc73f010c";
          hash = "sha256-T7XSS44Kw1UnfQcUtvL5PPu3LKbc8t00fTlykZeYq10=";
        };
        patches = (oldAttrs.patches or [ ]) ++ [ ./patches/better-e-binding.patch ];
      });

    initLuaContents.default = ''
      require("init")
    '';

    startPlugins.defaultFunc = import ./startPlugins;
    optPlugins.defaultFunc = import ./optPlugins;
    treesitterPackage.defaultFunc = import ./treesitter.nix;
    extraPackages.defaultFunc = import ./binaries.nix;

    devMode = {
      type = types.bool;
      default = false;
    };
    devPlugins.defaultFunc = { options }: [
      ((if options.devMode then toString else x: x) ../../nvim)
    ];
  };
}
