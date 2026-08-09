{ pkgs }:
let
  inherit (pkgs) callPackage;
in {
  # Custom plugins
  fFtT-highlights-nvim = callPackage ./startPlugins/fFtT-highlights-nvim.nix {};
  canola-nvim = callPackage ./startPlugins/canola-nvim.nix {};
  canola-collection = callPackage ./startPlugins/canola-collection.nix {};
  mini-indentscope = callPackage ./startPlugins/mini-indentscope.nix {};
  nvim-fundo = callPackage ./startPlugins/nvim-fundo.nix {};
  snacks-nvim = callPackage ./startPlugins/snacks-nvim.nix {};
  vim-nix = callPackage ./startPlugins/vim-nix.nix {};

  inherit (pkgs.vimPlugins)
    # Essentials
    auto-session
    blink-cmp
    conform-nvim
    fzf-lua
    lualine-lsp-progress
    lualine-nvim
    lz-n
    nvim-autopairs
    nvim-lspconfig
    nvim-surround
    rainbow-delimiters-nvim
    # Neat features
    colorful-menu-nvim # Show completion types in color
    luasnip
    tiny-inline-diagnostic-nvim
    # mini-nvim stuff
    mini-ai
    mini-comment
    mini-extra # More textobjects for mini-ai
    # Colorschemes
    onedarkpro-nvim
    tokyonight-nvim
    # Dependencies
    nvim-web-devicons
    promise-async
    ;

    # Since there's no license in the repo of this package, it defaults to
    # unfree. I could add config.allowUnfree to the flake.nix, but I prefer to
    # lie
    nvim-highlight-colors = pkgs.vimPlugins.nvim-highlight-colors.overrideAttrs { meta.license = []; };
}
