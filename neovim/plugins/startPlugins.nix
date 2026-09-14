{ pkgs }:
let
  inherit (pkgs) callPackage;
in {
  # Custom plugins
  canola-collection = callPackage ./startPlugins/canola-collection.nix {};
  canola-nvim = callPackage ./startPlugins/canola-nvim.nix {};
  fFtT-highlights-nvim = callPackage ./startPlugins/fFtT-highlights-nvim.nix {};
  mini-ai = callPackage ./startPlugins/mini-ai/package.nix {};
  mini-indentscope = callPackage ./startPlugins/mini-indentscope.nix {};
  nvim-fundo = callPackage ./startPlugins/nvim-fundo.nix {};
  snacks-nvim = callPackage ./startPlugins/snacks-nvim.nix {};
  tokyonight-nvim = callPackage ./startPlugins/tokyonight-nvim.nix {};
  vim-nix = callPackage ./startPlugins/vim-nix.nix {};

  inherit (pkgs.vimPlugins)
    auto-session
    blink-cmp
    colorful-menu-nvim # Show completion types in color
    conform-nvim
    fzf-lua
    lualine-lsp-progress
    lualine-nvim
    luasnip
    lz-n
    mini-comment
    mini-extra # More textobjects for mini-ai
    nvim-autopairs
    nvim-highlight-colors
    nvim-lspconfig
    nvim-surround
    onedarkpro-nvim
    rainbow-delimiters-nvim
    tiny-inline-diagnostic-nvim
    # Dependencies
    nvim-web-devicons
    promise-async
    ;
}
