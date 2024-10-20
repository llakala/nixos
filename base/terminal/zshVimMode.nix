{ pkgs, lib, ... }:

{
  hm.programs.zsh =
  {
    defaultKeymap = "viins";

    plugins = lib.singleton
    {
      name = "vi-mode";
      file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      src = pkgs.zsh-vi-mode;
    };

    initExtraFirst =
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
    '';
  };
}
