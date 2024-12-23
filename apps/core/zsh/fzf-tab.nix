{ pkgs, lib, ... }:

{
  hm.programs.zsh.plugins = lib.singleton
  {
    # Must be before plugins that wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting
    name = "fzf-tab";
    src = pkgs.zsh-fzf-tab;
    file = "share/fzf-tab/fzf-tab.plugin.zsh";
  };

  hm.programs.zsh.initExtra =
  /* bash */
  ''
    bindkey "^ " fzf-completion # Ctrl + Space
  '';
}