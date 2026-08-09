{ pkgs }:

# Binaries with a large closure, that I'll skip if I'm trying to download
# something quickly on a random machine, but want for normal life
with pkgs; [
  fish-lsp
  clang-tools
  basedpyright
  ruff
]
