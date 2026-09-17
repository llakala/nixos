{ inputs }:

with inputs.nixpkgs.pkgs; [
  # Language servers
  pkgs.lua-language-server
  pkgs.tinymist
  pkgs.nil
  pkgs.fish-lsp
  pkgs.clang-tools
  pkgs.basedpyright
  pkgs.ruff

  # Formatters
  pkgs.stylua
  pkgs.nixfmt
]
