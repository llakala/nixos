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
          rev = "7dbca1c4e2e83711df1ecd9f5e2a1612d64cc774";
          hash = "sha256-TAOPBXUcLLkGhYJwYMHE5EehxNedm6gxx4mlhR3UfTo=";
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
