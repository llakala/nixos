{ pkgs }:
let
  # To see all valid values, search this:
  # https://search.nixos.org/packages?channel=unstable&sort=alpha_asc&type=packages&query=vimPlugins.nvim-treesitter-parsers
  # Some languages like Lua aren't included bc nvim already includes them
  my-treesitter = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
    vim # Required, get an error without it

    # The languages I work in everyday
    comment # highlight todos and fixmes
    gitcommit
    lua
    luadoc
    nix

    # Languages I use less often
    bash
    fish
    gitignore
    git_rebase
    java
    python
    typst

    # Structured languages
    css
    csv
    diff # .patch files
    html
    json
    toml
    yaml

    # Languages I don't use much, but are common
    cpp
    javascript
    rust
    tsx
    typescript
  ]);
in
  [ my-treesitter ]
