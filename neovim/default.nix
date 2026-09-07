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
      rev = "48864161cd75ae4b58f7af94d6c9add0ba876107";
      hash = "sha256-e0vtGzeibyUiVO91sx/WyMt+D1JLF9fSu8kwjFZc7h8=";
    };
    patches = (oldAttrs.patches or [ ]) ++ [ ./plugins/patches/better-e-binding.patch ];
  });

  luaFiles = [
    "${./init.lua}"
  ];

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
