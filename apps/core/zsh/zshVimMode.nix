{ pkgs, lib, ... }:

let
  # My PR to add syntax highlighting when using `vv`
  myPatch = pkgs.fetchpatch
  {
    url = "https://patch-diff.githubusercontent.com/raw/jeffreytse/zsh-vi-mode/pull/305.patch";
    hash = "sha256-7vZDuNPGBSeRacP5s0d+wGwM9YiSB8IBe/VJ+7Li4sU=";
  };

  patchedPlugin = pkgs.zsh-vi-mode.overrideAttrs
  {
    patches = lib.singleton myPatch;
  };

in
{
  hm.programs.zsh =
  {
    defaultKeymap = "viins"; # Insert mode in new terminal session

    plugins = lib.singleton # Documentation seen here for adding new keybinds https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#custom-widgets-and-keybindings
    {
      name = "vi-mode";
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      src = patchedPlugin;
    };

    initExtraFirst = # language for treesitter: bash
    ''
      function my_delete_bind()
      {
        zvm_vi_delete
      }

      function zvm_after_lazy_keybindings()
      {
        zvm_define_widget my_delete_bind
        zvm_bindkey vicmd 'd' my_delete_bind
      }

      # Fix Ctrl+R, as recommended here https://github.com/jeffreytse/zsh-vi-mode/issues/242#issuecomment-2365253822
      function zvm_after_init()
      {
        zvm_bindkey viins "^R" fzf-history-widget
        zvm_bindkey viins "^F" fzf-file-widget
      }
    '';
  };
}
