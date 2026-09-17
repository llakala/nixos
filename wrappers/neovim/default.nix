{ types, ... }:

{
  options = {
    devMode = {
      type = types.bool;
      default = false;
    };

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
          rev = "7737589a0a83b7c31952a09c60a5bf630b3c468b";
          hash = "sha256-vX7uFvlGGhZ2ckDc1V1gqOz1vWyR/8cD5uubVYQjNTw=";
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
  };
}
