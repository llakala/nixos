{
  hm.programs.fzf = {
    enable = true;
  };

  # Basic vim bindings! Inspired from:
  # https://github.com/junegunn/fzf/blob/e5cd7f0a3a73ef598267c1e9f29b0fe9a80925ab/CHANGELOG.md?plain=1#L300
  hm.programs.fish.interactiveShellInit = ''
    set FZF_DEFAULT_OPTS '--with-shell="sh -c" --no-input --bind \'start:unbind(down,up)+hide-input,j:down,k:up,i:show-input+unbind(i,j,k)\' --bind \'esc:transform:if [[ "$FZF_INPUT_STATE" = enabled ]]; then echo "hide-input+rebind(i,j,k)"; else echo abort; fi\'''
  '';
}
