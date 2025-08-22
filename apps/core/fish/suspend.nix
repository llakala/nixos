{
  hm.programs.fish.interactiveShellInit = # fish
  ''
    # Ctrl+Z to resume
    # Don't ask me how this works, I have no clue! But it means repeatedly
    # pressing Ctrl+Z to suspend and unsuspend doesn't create a new line every
    # time - which is wonderful. Thanks to krobelus on Matrix for the snippet!
    #
    # Also note that this does leave the first part of the command in your title
    # when running multiple times - but that's a Fish bug I've had forever, and
    # I'll accept it if it means we don't have to deal with constant repaints.
    bind -M insert \cz 'fg 2>/dev/null'
    functions --copy fish_job_summary job_summary
    function fish_job_summary
      if contains STOPPED $argv
        return
      end
      job_summary $argv
    end

  '';
}
