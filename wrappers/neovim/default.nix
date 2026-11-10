{ types, promise, ... }:

{
  inputs = {
    self.from = { parent }: parent.self;
  };

  options = {
    package.default = promise (
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
          rev = "0c4b90023dac24f42ef24278b22fa357b39d38c6";
          hash = "sha256-PISjOs4QekGUweHKKXRjyLKhE5q9q+XEFf2OqkAVxno=";
        };
        patches = (oldAttrs.patches or []) ++ [
          ./patches/better-e-binding.patch
          ./patches/inclusive.patch
        ];
      })
    );

    initLuaContents.default = ''
      require("init")
    '';

    startPlugins.default = promise (import ./startPlugins);
    optPlugins.default = promise (import ./optPlugins);
    treesitterPackage.default = promise (import ./treesitter.nix);
    extraPackages.default = promise (import ./binaries.nix);

    devMode = {
      type = types.bool;
      default = false;
    };
    devPlugins.default = promise ({ options }: [
      ((if options.devMode then toString else x: x) ../../nvim)
    ]);
  };
}
