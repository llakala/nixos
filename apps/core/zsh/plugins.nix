{ pkgs, ... }:
{
  hm.programs.zsh =
  {
    autosuggestion.enable = true;
    enableCompletion = true;
  };

  hm.programs.zsh.plugins =
  [
    {
      name = "zsh-fast-syntax-highlighting";
      src = pkgs.zsh-fast-syntax-highlighting;
      file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
    }

    {
      name = "zsh-forgit";
      src = pkgs.zsh-forgit;
      file = "share/zsh/zsh-forgit/forgit.plugin.zsh";
    }

  ];
}