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
          rev = "d0596fa4429c0a5e2bd83057cd9e713b5b4587de";
          hash = "sha256-8/m02bnWph7n/eFl3sqBvizi7iw1MR9BAjqndjJMqAA=";
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
