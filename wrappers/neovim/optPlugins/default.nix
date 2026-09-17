{ inputs }:
let
  inherit (inputs.nixpkgs.pkgs) callPackage vimPlugins;
in {
  lazydev-nvim = callPackage ./lazydev-nvim.nix {};

  inherit (vimPlugins)
    typst-preview-nvim
    nvim-jdtls
    markdown-preview-nvim
    vim-fugitive
    vim-rhubarb # Make `:GBrowse` from fugitive work with Github
    ;
}
