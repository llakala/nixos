{ inputs }:
let
  inherit (inputs.nixpkgs.pkgs) callPackage vimPlugins;
in
{
  # Custom plugins
  canola-collection = callPackage ./canola-collection.nix { };
  canola-nvim = callPackage ./canola-nvim.nix { };
  Colorizer = callPackage ./Colorizer.nix {};
  fFtT-highlights-nvim = callPackage ./fFtT-highlights-nvim.nix { };
  mini-ai = callPackage ./mini-ai/package.nix { };
  mini-indentscope = callPackage ./mini-indentscope/package.nix { };
  nvim-fundo = callPackage ./nvim-fundo.nix { };
  snacks-nvim = callPackage ./snacks-nvim/package.nix { };
  rainbow-delimiters-nvim = callPackage ./rainbow-delimiters-nvim/package.nix {};
  tokyonight-nvim = callPackage ./tokyonight-nvim.nix { };
  vim-nix = callPackage ./vim-nix/package.nix { };

  inherit (vimPlugins)
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
    nvim-lspconfig
    nvim-surround
    onedarkpro-nvim
    tiny-inline-diagnostic-nvim
    # Dependencies
    nvim-web-devicons
    promise-async
    ;
}
