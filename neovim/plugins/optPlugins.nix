{ pkgs }:
let
  inherit (pkgs) callPackage;
in {
  lazydev-nvim = callPackage ./optPlugins/lazydev-nvim.nix {};

  inherit (pkgs.vimPlugins)
    typst-preview-nvim
    nvim-jdtls
    markdown-preview-nvim
    vim-fugitive
    vim-rhubarb # Make `:GBrowse` from fugitive work with Github
    ;
}
