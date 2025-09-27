{ pkgs, lib, ... }:

{
  environment.systemPackages = [ pkgs.fzf ];
  programs.fish.interactiveShellInit = lib.mkOrder 200 ''
    ${lib.getExe pkgs.fzf} --fish | source
  '';

  # Basic vim bindings! Inspired from:
  # https://github.com/junegunn/fzf/blob/e5cd7f0a3a73ef598267c1e9f29b0fe9a80925ab/CHANGELOG.md?plain=1#L300
  #
  # This is purposefully minimal, so when we write individual FZF scripts, they
  # can safely inherit from this, and add their own settings on top of this. It
  # also doesn't start in normal mode
  environment.variables.FZF_DEFAULT_OPTS = ''
    --with-shell=\"sh -c\"
    --bind 'i:show-input+trigger(start),esc:hide-input+trigger(start)'
    --bind 'j:down,k:up,f:jump-accept'
    --bind 'start:toggle-bind(i,j,k,f)'
    --bind 'ctrl-l:accept'
  '';
}
