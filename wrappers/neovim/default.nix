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
          rev = "4f55f288f4ac0a05dcdab0fb525d89169488591b";
          hash = "sha256-YMlnEslccGnK7giIrX7YKu3+8PUY/xjyYafTSXS7eJg=";
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
