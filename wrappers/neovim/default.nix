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
          rev = "ac9ddec6b855a54193899f95da2d94d8224b31af";
          hash = "sha256-aZBCOTVbBWil/lOpFcrRALvIsv39xZTWcNU4xUrF1/A=";
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
