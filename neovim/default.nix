{
  sources ? import ../other/npins,
  pkgs ? import sources.nixpkgs { config.allowUnfree = true; },
  localPackages ? import ../packages { inherit sources pkgs; },
}:

let
  args = { inherit pkgs; };
  mnw = import sources.mnw;
in
mnw.lib.wrap pkgs {
  appName = "nvim";
  neovim = pkgs.neovim-unwrapped.overrideAttrs (oldAttrs: {
    doCheck = false;
    doInstallCheck = false;
    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "493a4dd57127de50c76e6a627bff27c64d5adf91";
      hash = "sha256-bXPTTwMKK8jnGqWJhHnQibjqiSyGO3f/LZ2o31nGeWk=";
    };
    patches = (oldAttrs.patches or [ ]) ++ [ ./plugins/patches/better-e-binding.patch ];
  });

  initLua = ''
    require("init")
  '';

  plugins = {
    startAttrs = import ./plugins/startPlugins.nix args;
    start = import ./plugins/treesitter.nix args;
    optAttrs = import ./plugins/optPlugins.nix args;
    # Prefixing the name with _ to read my config first when iterating through
    # all `plugin/` files. This prevents plugins from trying to read vim.g
    # values before they've been set (looking at you, canola)
    dev._config = {
      pure = "${./nvim}";
      impure = "/home/emanresu/Documents/projects/nixos/neovim/nvim"; # Absolute path needed
    };
  };
  extraBinPath =
    import ./plugins/binaries.nix args
    ++ [ localPackages.sadin ]
    # TODO: allow disabling these again
    ++ (import ./plugins/extraBinaries.nix args);
}
