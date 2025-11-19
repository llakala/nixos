{
  # We don't modify the inputrc in /etc, since nixos puts some sane defaults
  # there
  hm.home.file.".inputrc".text = /* readline */ ''
    $include /etc/inputrc

    "\C-h": unix-word-rubout # ctrl+backspace

    # Moving through history will use the prefix of the entered command
    "\e[A": history-search-backward # up
    "\e[B": history-search-forward # down
    "\C-p": history-search-backward
    "\C-n": history-search-forward
  '';
}
