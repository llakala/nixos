{ config, self, ... }:

{
  features.files = "yazi"; # Change if we ever stop using Yazi

  environment.systemPackages = [ self.wrappers.yazi.drv ];

  # When pressing Ctrl+y, go to the last directory we were in with Yazi Yazi
  # recommends an alternative where you run `$shell` and it goes into fish, but
  # then I don't get Ctrl+z to resume the process, I have to do Ctrl+d. So we
  # have the user do it manually when needed. Perfect? Far from it. But I don't
  # know if there's a way to suspend Yazi and have fish CATCH that suspension. I
  # tried watching for SIGTSTP with a fish function, but had no luck. I think
  # it's because Yazi is the one that gets suspended. Maybe there's some way? If
  # you see this and think you have an idea, let me know via an issue or email.
  programs.fish.interactiveShellInit =
  assert config.features.shell == "fish"; # fish
  ''
    bind -M insert \cy 'cd (cat /tmp/yazi-cwd-suspend); commandline -f repaint'

    # From https://github.com/yazi-rs/yazi-rs.github.io/blob/92b34e7dc31b025724a9eb5f5ce8b63268ce5b87/docs/quick-start.md?plain=1#L40
    function y
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      yazi $argv --cwd-file="$tmp"
      if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
      end
      rm -f -- "$tmp"
    end
  '';
}
