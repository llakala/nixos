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
          rev = "898e6f884e1331b92dc9deb5148091b32df017ca";
          hash = "sha256-h4jVBM12UT8dF6U1aNrZeSAZn9j66MEg72yGqrVntVg=";
        };
        patches = (oldAttrs.patches or []) ++ [ ./patches/better-e-binding.patch ];
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
