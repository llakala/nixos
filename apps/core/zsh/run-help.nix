{
  hm.programs.zsh.initExtra =
  /* bash */
  ''
    (( $+aliases[run-help] )) && unalias run-help
    autoload -Uz run-help
  '';

  environment.shellAliases.help = "run-help";
}