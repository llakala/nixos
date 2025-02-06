{
  hm.programs.fish.interactiveShellInit =
  /* fish */
  ''
    # Doesn't work with the home-manager fish plugins option, since it quotes fish_preexec
    function __commandline_ignore_history --on-event fish_preexec
      set -l ignored_terms fg
      history delete --exact --case-sensitive $ignored_terms
    end

    # Ctrl+Z again to resume
    # We run it as an actual command, since when I simply do 'fg' as the bind,
    # it doesn't seem to reset fish_title correctly
    # We have a function elsewhere to remove any instances of `fg` from history
    bind -M insert \cz 'commandline fg; commandline -f execute'
  '';
}