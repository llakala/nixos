{ pkgs, lib, ... }:

{
  hm.programs.zsh.plugins = lib.singleton
  {
    name = "fzf-git-sh";
    src = pkgs.fzf-git-sh;
    file = "share/fzf-git-sh/fzf-git.sh";
  };

  hm.programs.zsh.initExtra =
  /* bash */
  ''
    # Let keybinds work with zsh-vi-mode, see https://github.com/junegunn/fzf-git.sh/issues/23
    bindkey -r '^G'

    stty -ixon
  '';

}
