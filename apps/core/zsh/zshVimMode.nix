{ pkgs, lib, ... }:

{
  hm.programs.zsh =
  {
    defaultKeymap = "viins"; # Insert mode in new terminal session

    plugins = lib.singleton # Documentation seen here for adding new keybinds https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#custom-widgets-and-keybindings
    {
      name = "vi-mode";
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      src = pkgs.zsh-vi-mode;
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
      }
    '';
  };
}
