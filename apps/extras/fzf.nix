{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.fzf ];

  # Basic vim bindings! Inspired from:
  # https://github.com/junegunn/fzf/blob/e5cd7f0a3a73ef598267c1e9f29b0fe9a80925ab/CHANGELOG.md?plain=1#L300
  environment.variables.FZF_DEFAULT_OPTS = ''
    --with-shell=\"sh -c\"
    --no-input
    --bind 'j:down,k:up'
    --bind 'down:ignore,up:ignore'
    --bind 'i:show-input+unbind(i,j,k),esc:hide-input+rebind(i,j,k)'
  '';
}
