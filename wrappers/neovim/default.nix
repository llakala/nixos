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
          rev = "3ef56c5fccd6e8c861857bf8b38f50c6472e7005";
          hash = "sha256-ZlsJbuFJsKJASVvC9Y7ygKU708avIJHDK4KiDlbmiPc=";
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
