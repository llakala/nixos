{
  hm.programs.zsh.initExtra = # When exiting yazi, open terminal in path navigated to if requested
  # bash
  ''
    function y()
    {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
      command yazi "$@" --cwd-file="$tmp" # Use `command yazi` to get around our yazi alias

      if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
      fi

      rm -f -- "$tmp"
    }
  '';

  environment.shellAliases.yazi = "echo 'USE y DUMMY'"; # We should always be using the `y` function, it's shorter and better

}
