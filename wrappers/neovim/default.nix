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
          rev = "4b26a2a81ebc03f71ceb503ce6b6401b08911540";
          hash = "sha256-trwCExf6o8s4L1Esaj6ecuWwNUrxTSNmq7QCwWkf4FQ=";
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
