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
          rev = "78a3f5aa4b22bf1532349ea5b472c7d8afb7a55c";
          hash = "sha256-gwAToS5QKrNK4j9OqK7nbOmjkSAjF0zq3dZ+B0CS744=";
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
